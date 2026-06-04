import 'dart:async';
import 'dart:math';

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../services/supabase_service.dart';

enum PatternBreakerStatus { waiting, playing, finished }

class PatternBreakerViewModel extends BaseViewModel {
  final SupabaseService _supabaseService = locator<SupabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('PatternBreakerViewModel');
  final Random _random = Random();

  static const int _gameDuration = 120;
  static const int _feedbackMillis = 1000;
  static const int _winScore = 10;

  static const List<Map<String, dynamic>> _patterns = [
    {'seq': ['2', '4', '8', '16'], 'answer': '32'},
    {'seq': ['1', '4', '9', '16'], 'answer': '25'},
    {'seq': ['3', '6', '9', '12'], 'answer': '15'},
    {'seq': ['1', '2', '4', '7', '11'], 'answer': '16'},
    {'seq': ['5', '10', '20', '40'], 'answer': '80'},
    {'seq': ['100', '50', '25'], 'answer': '12.5'},
    {'seq': ['1', '1', '2', '3', '5'], 'answer': '8'},
    {'seq': ['2', '6', '12', '20'], 'answer': '30'},
    {'seq': ['red', 'blue', 'red', 'blue'], 'answer': 'red'},
    {'seq': ['circle', 'square', 'circle', 'square'], 'answer': 'circle'},
    {'seq': ['1', '3', '7', '15'], 'answer': '31'},
    {'seq': ['10', '9', '7', '4'], 'answer': '0'},
    {'seq': ['A', 'C', 'E', 'G'], 'answer': 'I'},
    {'seq': ['2', '3', '5', '7', '11'], 'answer': '13'},
    {'seq': ['4', '8', '16', '32'], 'answer': '64'},
    {
      'seq': ['triangle', 'triangle', 'square', 'triangle', 'triangle'],
      'answer': 'square',
    },
    {'seq': ['1', '8', '27', '64'], 'answer': '125'},
    {'seq': ['Z', 'Y', 'X', 'W'], 'answer': 'V'},
    {'seq': ['0', '1', '1', '2', '3', '5'], 'answer': '8'},
    {'seq': ['3', '9', '27', '81'], 'answer': '243'},
  ];

  String? _matchId;
  int _stakeAmount = 0;
  bool _isChallenger = true;

  List<int> _patternOrder = [];
  int _index = 0;

  List<String> _sequence = [];
  List<String> get sequence => _sequence;

  String _correctAnswer = '';
  String get correctAnswer => _correctAnswer;

  List<String> _options = [];
  List<String> get options => _options;

  int _playerScore = 0;
  int get playerScore => _playerScore;

  int _opponentScore = 0;
  int get opponentScore => _opponentScore;

  int _timeRemaining = _gameDuration;
  int get timeRemaining => _timeRemaining;

  PatternBreakerStatus _gameStatus = PatternBreakerStatus.waiting;
  PatternBreakerStatus get gameStatus => _gameStatus;

  bool _isWinner = false;
  bool get isWinner => _isWinner;

  bool? _lastAnswerCorrect;
  bool? get lastAnswerCorrect => _lastAnswerCorrect;

  String? _selectedAnswer;
  String? get selectedAnswer => _selectedAnswer;

  bool _hasAnswered = false;
  bool get hasAnswered => _hasAnswered;

  int get stakeAmount => _stakeAmount;

  Timer? _timer;
  Timer? _feedbackTimer;

  void initGame({
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
  }) {
    _matchId = matchId;
    _stakeAmount = stakeAmount;
    // TODO: set from match data when real matchmaking is wired
    _isChallenger = true;
    _logger.i('Pattern Breaker starting — match $matchId');
    if (matchId.isNotEmpty) {
      _supabaseService.subscribeToMatch(matchId, _onMatchUpdate);
    }
    _patternOrder = List<int>.generate(_patterns.length, (i) => i)
      ..shuffle(_random);
    _loadNextPattern();
    _startTimer();
    _gameStatus = PatternBreakerStatus.playing;
    notifyListeners();
  }

  void onOptionSelected(String answer) {
    if (_gameStatus != PatternBreakerStatus.playing) return;
    if (_hasAnswered) return;
    _hasAnswered = true;
    _selectedAnswer = answer;
    final correct = answer == _correctAnswer;
    _lastAnswerCorrect = correct;
    if (correct) {
      _playerScore++;
    }
    _syncScore();
    _logger.d('Pattern answer ${correct ? 'right' : 'wrong'}');
    notifyListeners();
    _checkWinCondition();
    if (_gameStatus == PatternBreakerStatus.finished) return;
    _feedbackTimer = Timer(
      const Duration(milliseconds: _feedbackMillis),
      _advancePattern,
    );
  }

  void _advancePattern() {
    _index = (_index + 1) % _patternOrder.length;
    _loadNextPattern();
  }

  void _loadNextPattern() {
    final entry = _patterns[_patternOrder[_index]];
    _sequence = List<String>.from(entry['seq'] as List);
    _correctAnswer = entry['answer'] as String;
    _options = _buildOptions(_correctAnswer);
    _hasAnswered = false;
    _lastAnswerCorrect = null;
    _selectedAnswer = null;
    notifyListeners();
  }

  List<String> _buildOptions(String correct) {
    final pool = _patterns
        .map((m) => m['answer'] as String)
        .where((a) => a != correct)
        .toSet()
        .toList()
      ..shuffle(_random);
    final distractors = pool.take(3).toList();
    return [correct, ...distractors]..shuffle(_random);
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
    if (_gameStatus == PatternBreakerStatus.finished) return;
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
    if (_matchId != null && _matchId!.isNotEmpty) {
      _supabaseService.unsubscribeFromMatch(_matchId!);
    }
    _isWinner = playerWon;
    _gameStatus = PatternBreakerStatus.finished;
    _logger.i('Game ended — playerWon: $playerWon');
    notifyListeners();
  }

  Future<void> _syncScore() async {
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
    if (_matchId != null && _matchId!.isNotEmpty) {
      _supabaseService.unsubscribeFromMatch(_matchId!);
    }
    super.dispose();
  }
}
