import 'dart:async';
import 'dart:math';

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../services/supabase_service.dart';

enum ChainReflexStatus { waiting, playing, finished }

class ChainReflexViewModel extends BaseViewModel {
  final SupabaseService _supabaseService = locator<SupabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('ChainReflexViewModel');
  final Random _random = Random();

  static const int _winScore = 10;
  static const int _gameDuration = 60;
  static const List<String> _shapes = [
    'circle',
    'square',
    'triangle',
    'diamond',
  ];
  static const List<String> _colors = ['red', 'blue', 'green', 'yellow'];

  String? _matchId;
  int _stakeAmount = 0;

  Map<String, dynamic> _currentTarget = {};
  Map<String, dynamic> get currentTarget => _currentTarget;

  List<Map<String, dynamic>> _options = [];
  List<Map<String, dynamic>> get options => _options;

  int _playerScore = 0;
  int get playerScore => _playerScore;

  int _opponentScore = 0;
  int get opponentScore => _opponentScore;

  int _timeRemaining = _gameDuration;
  int get timeRemaining => _timeRemaining;

  ChainReflexStatus _gameStatus = ChainReflexStatus.waiting;
  ChainReflexStatus get gameStatus => _gameStatus;

  bool _isWinner = false;
  bool get isWinner => _isWinner;

  int get stakeAmount => _stakeAmount;

  Timer? _timer;

  void initGame({
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
  }) {
    _matchId = matchId;
    _stakeAmount = stakeAmount;
    _logger.i('Chain Reflex starting — match $matchId');
    if (matchId.isNotEmpty) {
      _supabaseService.subscribeToMatch(matchId, _onMatchUpdate);
    }
    _generateNewTarget();
    _startTimer();
    _gameStatus = ChainReflexStatus.playing;
    notifyListeners();
  }

  void onTargetTap(String shape, String color) {
    if (_gameStatus != ChainReflexStatus.playing) return;
    if (shape != _currentTarget['shape'] || color != _currentTarget['color']) {
      return;
    }
    _playerScore++;
    _logger.d('Correct tap — score $_playerScore');
    _generateNewTarget();
    _syncScore();
    _checkWinCondition();
  }

  void _generateNewTarget() {
    final shape = _shapes[_random.nextInt(_shapes.length)];
    final color = _colors[_random.nextInt(_colors.length)];
    _currentTarget = {'shape': shape, 'color': color};
    _options = _buildOptions(shape, color);
    notifyListeners();
  }

  List<Map<String, dynamic>> _buildOptions(String shape, String color) {
    final list = <Map<String, dynamic>>[
      {'shape': shape, 'color': color},
    ];
    while (list.length < 4) {
      final s = _shapes[_random.nextInt(_shapes.length)];
      final c = _colors[_random.nextInt(_colors.length)];
      if (s != shape || c != color) list.add({'shape': s, 'color': c});
    }
    list.shuffle(_random);
    return list;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timeRemaining > 0) {
        _timeRemaining--;
        notifyListeners();
      }
      if (_timeRemaining == 0) _checkWinCondition();
    });
  }

  void _onMatchUpdate(Map<String, dynamic> update) {
    _logger.d('Match update received');
    final score = update['opponent_score'];
    if (score is int && score != _opponentScore) {
      _opponentScore = score;
      notifyListeners();
      _checkWinCondition();
    }
  }

  void _checkWinCondition() {
    if (_gameStatus == ChainReflexStatus.finished) return;
    if (_playerScore >= _winScore) {
      _endGame(true);
    } else if (_opponentScore >= _winScore) {
      _endGame(false);
    } else if (_timeRemaining == 0) {
      _endGame(_playerScore >= _opponentScore);
    }
  }

  void _endGame(bool playerWon) {
    _timer?.cancel();
    if (_matchId != null && _matchId!.isNotEmpty) {
      _supabaseService.unsubscribeFromMatch(_matchId!);
    }
    _isWinner = playerWon;
    _gameStatus = ChainReflexStatus.finished;
    _logger.i('Game ended — playerWon: $playerWon');
    notifyListeners();
  }

  Future<void> _syncScore() async {
    if (_matchId == null || _matchId!.isEmpty) return;
    try {
      await _supabaseService.updateMatchState(
        _matchId!,
        {'challenger_score': _playerScore},
      );
    } catch (e, stack) {
      _logger.e('Score sync failed', error: e, stackTrace: stack);
    }
  }

  Future<void> navigateToHome() async {
    await _navigationService.replaceWith(Routes.homeView);
  }

  @override
  void dispose() {
    _timer?.cancel();
    if (_matchId != null && _matchId!.isNotEmpty) {
      _supabaseService.unsubscribeFromMatch(_matchId!);
    }
    super.dispose();
  }
}
