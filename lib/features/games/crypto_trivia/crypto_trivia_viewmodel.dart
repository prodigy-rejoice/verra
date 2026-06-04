import 'dart:async';
import 'dart:math';

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../services/supabase_service.dart';

enum CryptoTriviaStatus { waiting, playing, finished }

class CryptoTriviaViewModel extends BaseViewModel {
  final SupabaseService _supabaseService = locator<SupabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('CryptoTriviaViewModel');
  final Random _random = Random();

  static const int _winScore = 7;
  static const int _correctPoints = 2;
  static const int _gameDuration = 90;
  static const int _questionsPerMatch = 10;
  static const int _feedbackMillis = 1000;

  static const List<Map<String, String>> _allQuestions = [
    {'q': 'What blockchain is Verra built on?', 'a': 'Sui'},
    {'q': 'What language are Sui smart contracts written in?', 'a': 'Move'},
    {'q': 'What does NFT stand for?', 'a': 'Non-Fungible Token'},
    {'q': 'What is a gas fee?', 'a': 'Cost to execute a transaction'},
    {'q': 'What does DeFi stand for?', 'a': 'Decentralised Finance'},
    {'q': 'What is zkLogin?', 'a': 'Sign in with Web2 credentials on Sui'},
    {'q': 'What is a smart contract?', 'a': 'Self-executing code on blockchain'},
    {'q': 'What is Walrus?', 'a': 'Decentralised storage on Sui'},
    {'q': 'What is a soulbound token?', 'a': 'Non-transferable blockchain token'},
    {'q': 'What does PTB stand for in Sui?', 'a': 'Programmable Transaction Block'},
    {'q': 'What is a seed phrase?', 'a': 'Recovery words for a crypto wallet'},
    {'q': 'What is on-chain?', 'a': 'Data stored directly on the blockchain'},
    {'q': 'What is a DEX?', 'a': 'Decentralised Exchange'},
    {'q': 'What is minting?', 'a': 'Creating a new token or NFT'},
    {'q': 'What is a block explorer?', 'a': 'Tool to view blockchain transactions'},
    {'q': 'What is liquidity?', 'a': 'Available assets in a trading pool'},
    {'q': 'What is a DAO?', 'a': 'Decentralised Autonomous Organisation'},
    {'q': 'What is slippage?', 'a': 'Price change during a transaction'},
    {'q': 'What is a whitelist?', 'a': 'Pre-approved list for early access'},
    {'q': 'What is TVL?', 'a': 'Total Value Locked'},
  ];

  String? _matchId;
  int _stakeAmount = 0;
  bool _isChallenger = true;

  List<Map<String, String>> _selected = [];
  int _index = 0;

  String _currentQuestion = '';
  String get currentQuestion => _currentQuestion;

  List<String> _options = [];
  List<String> get options => _options;

  int _playerScore = 0;
  int get playerScore => _playerScore;

  int _opponentScore = 0;
  int get opponentScore => _opponentScore;

  int _timeRemaining = _gameDuration;
  int get timeRemaining => _timeRemaining;

  bool _hasAnswered = false;
  bool get hasAnswered => _hasAnswered;

  bool? _lastAnswerCorrect;
  bool? get lastAnswerCorrect => _lastAnswerCorrect;

  String? _selectedAnswer;
  String? get selectedAnswer => _selectedAnswer;

  CryptoTriviaStatus _gameStatus = CryptoTriviaStatus.waiting;
  CryptoTriviaStatus get gameStatus => _gameStatus;

  bool _isWinner = false;
  bool get isWinner => _isWinner;

  int get stakeAmount => _stakeAmount;

  String get correctAnswer =>
      _selected.isEmpty ? '' : _selected[_index]['a']!;

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
    _logger.i('Crypto Trivia starting — match $matchId');
    if (matchId.isNotEmpty) {
      _supabaseService.subscribeToMatch(matchId, _onMatchUpdate);
    }
    final pool = List<Map<String, String>>.from(_allQuestions)
      ..shuffle(_random);
    _selected = pool.take(_questionsPerMatch).toList();
    _loadNextQuestion();
    _startTimer();
    _gameStatus = CryptoTriviaStatus.playing;
    notifyListeners();
  }

  void onAnswerSelected(String answer) {
    if (_gameStatus != CryptoTriviaStatus.playing) return;
    if (_hasAnswered) return;
    _hasAnswered = true;
    _selectedAnswer = answer;
    final correct = answer == correctAnswer;
    _lastAnswerCorrect = correct;
    if (correct) {
      _playerScore += _correctPoints;
    }
    _syncScore();
    _logger.d('Answer ${correct ? 'correct' : 'wrong'} — score $_playerScore');
    notifyListeners();
    _checkWinCondition();
    if (_gameStatus == CryptoTriviaStatus.finished) return;
    _feedbackTimer = Timer(
      const Duration(milliseconds: _feedbackMillis),
      _advanceQuestion,
    );
  }

  void _advanceQuestion() {
    _index++;
    if (_index >= _selected.length) {
      _endGame(_playerScore >= _opponentScore);
      return;
    }
    _loadNextQuestion();
  }

  void _loadNextQuestion() {
    final entry = _selected[_index];
    _currentQuestion = entry['q']!;
    _options = _buildOptions(entry['a']!);
    _hasAnswered = false;
    _lastAnswerCorrect = null;
    _selectedAnswer = null;
    notifyListeners();
  }

  List<String> _buildOptions(String correct) {
    final pool = _allQuestions
        .map((m) => m['a']!)
        .where((a) => a != correct)
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
    if (_gameStatus == CryptoTriviaStatus.finished) return;
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
    _feedbackTimer?.cancel();
    if (_matchId != null && _matchId!.isNotEmpty) {
      _supabaseService.unsubscribeFromMatch(_matchId!);
    }
    _isWinner = playerWon;
    _gameStatus = CryptoTriviaStatus.finished;
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
