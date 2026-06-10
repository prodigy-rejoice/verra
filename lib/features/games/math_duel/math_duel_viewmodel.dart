import 'dart:async';
import 'dart:math';

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../services/supabase_service.dart';

enum MathDuelStatus { waiting, playing, finished }

class MathDuelViewModel extends BaseViewModel {
  final SupabaseService _supabaseService = locator<SupabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final Logger _logger = getLogger('MathDuelViewModel');
  final Random _random = Random();

  static const int _gameDuration = 60;
  static const int _feedbackMillis = 400;
  static const int _winScore = 10;
  static const List<int> _percentValues = [10, 20, 25, 50];

  String? _matchId;
  int _stakeAmount = 0;
  bool _isChallenger = true;
  bool _hasResigned = false;
  bool _isPractice = false;
  bool get isPractice => _isPractice;

  String _currentProblem = '';
  String get currentProblem => _currentProblem;

  int _correctAnswer = 0;
  int get correctAnswer => _correctAnswer;

  String _playerInput = '';
  String get playerInput => _playerInput;

  int _playerScore = 0;
  int get playerScore => _playerScore;

  int _opponentScore = 0;
  int get opponentScore => _opponentScore;

  int _timeRemaining = _gameDuration;
  int get timeRemaining => _timeRemaining;

  MathDuelStatus _gameStatus = MathDuelStatus.waiting;
  MathDuelStatus get gameStatus => _gameStatus;

  bool _isWinner = false;
  bool get isWinner => _isWinner;

  bool? _lastSubmitCorrect;
  bool? get lastSubmitCorrect => _lastSubmitCorrect;

  int get stakeAmount => _stakeAmount;

  Timer? _timer;
  Timer? _feedbackTimer;

  void initGame({
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
  }) {
    _matchId = matchId;
    _stakeAmount = stakeAmount;
    _isPractice = isPractice;
    _isChallenger = true;
    _logger.i('Math Duel starting — match $matchId (practice=$isPractice)');
    if (!_isPractice && matchId.isNotEmpty) {
      _supabaseService.subscribeToMatch(matchId, _onMatchUpdate);
    }
    _generateProblem();
    _startTimer();
    _gameStatus = MathDuelStatus.playing;
    notifyListeners();
  }

  Future<void> resign() async {
    if (_gameStatus != MathDuelStatus.playing) return;
    if (_hasResigned) return;
    final response = await _dialogService.showConfirmationDialog(
      title: 'Resign?',
      description:
          'You will forfeit your staked rep to your opponent. This cannot be undone.',
      confirmationTitle: 'Resign',
      cancelTitle: 'Cancel',
    );
    if (response?.confirmed == true) {
      _hasResigned = true;
      _logger.i('Player resigned');
      _endGame(false);
    }
  }

  void onNumberTap(String digit) {
    if (_gameStatus != MathDuelStatus.playing) return;
    if (_playerInput.length >= 6) return;
    _playerInput += digit;
    notifyListeners();
  }

  void onDelete() {
    if (_gameStatus != MathDuelStatus.playing) return;
    if (_playerInput.isEmpty) return;
    _playerInput = _playerInput.substring(0, _playerInput.length - 1);
    notifyListeners();
  }

  Future<void> onSubmit() async {
    if (_gameStatus != MathDuelStatus.playing) return;
    if (_playerInput.isEmpty) return;
    final parsed = int.tryParse(_playerInput);
    final correct = parsed != null && parsed == _correctAnswer;
    _lastSubmitCorrect = correct;
    if (correct) _playerScore++;
    _logger.d('Submit ${correct ? 'correct' : 'wrong'} — score $_playerScore');
    notifyListeners();
    await _syncScore();
    _checkWinCondition();
    if (_gameStatus == MathDuelStatus.finished) return;
    _feedbackTimer?.cancel();
    _feedbackTimer = Timer(
      const Duration(milliseconds: _feedbackMillis),
      _afterSubmitFlash,
    );
  }

  void _afterSubmitFlash() {
    if (_lastSubmitCorrect == true) {
      _generateProblem();
    } else {
      _playerInput = '';
    }
    _lastSubmitCorrect = null;
    notifyListeners();
  }

  void _generateProblem() {
    switch (_random.nextInt(4)) {
      case 0:
        _buildAddition();
        break;
      case 1:
        _buildSubtraction();
        break;
      case 2:
        _buildMultiplication();
        break;
      default:
        _buildPercentage();
    }
    _playerInput = '';
    notifyListeners();
  }

  void _buildAddition() {
    final a = 10 + _random.nextInt(90);
    final b = 10 + _random.nextInt(90);
    _correctAnswer = a + b;
    _currentProblem = '$a + $b';
  }

  void _buildSubtraction() {
    var a = 10 + _random.nextInt(90);
    var b = 10 + _random.nextInt(90);
    if (b > a) {
      final t = a;
      a = b;
      b = t;
    }
    _correctAnswer = a - b;
    _currentProblem = '$a - $b';
  }

  void _buildMultiplication() {
    final a = 2 + _random.nextInt(11);
    final b = 2 + _random.nextInt(11);
    _correctAnswer = a * b;
    _currentProblem = '$a × $b';
  }

  void _buildPercentage() {
    final pct = _percentValues[_random.nextInt(_percentValues.length)];
    final base = (2 + _random.nextInt(19)) * 10;
    _correctAnswer = (pct * base) ~/ 100;
    _currentProblem = '$pct% of $base';
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
    final opponentColumn =
        _isChallenger ? 'opponent_score' : 'challenger_score';
    final opponentScore = update[opponentColumn] as int? ?? 0;
    if (opponentScore != _opponentScore) {
      _opponentScore = opponentScore;
      notifyListeners();
      _checkWinCondition();
    }
  }

  void _checkWinCondition() {
    if (_gameStatus == MathDuelStatus.finished) return;
    if (_playerScore >= _winScore) {
      _endGame(true);
      return;
    }
    if (_opponentScore >= _winScore) {
      _endGame(false);
      return;
    }
    if (_timeRemaining == 0) {
      _endGame(_playerScore >= _opponentScore);
    }
  }

  void _endGame(bool playerWon) {
    _timer?.cancel();
    _feedbackTimer?.cancel();
    if (!_isPractice && _matchId != null && _matchId!.isNotEmpty) {
      _supabaseService.unsubscribeFromMatch(_matchId!);
    }
    _isWinner = playerWon;
    _gameStatus = MathDuelStatus.finished;
    _logger.i('Game ended — playerWon: $playerWon');
    notifyListeners();
  }

  Future<void> _syncScore() async {
    if (_isPractice) return;
    if (_matchId == null || _matchId!.isEmpty) return;
    try {
      final column = _isChallenger ? 'challenger_score' : 'opponent_score';
      await _supabaseService.updateMatchState(
        _matchId!,
        {column: _playerScore},
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
    _feedbackTimer?.cancel();
    if (!_isPractice && _matchId != null && _matchId!.isNotEmpty) {
      _supabaseService.unsubscribeFromMatch(_matchId!);
    }
    super.dispose();
  }
}
