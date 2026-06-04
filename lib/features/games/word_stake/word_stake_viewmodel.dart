import 'dart:async';
import 'dart:math';

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../services/supabase_service.dart';

enum WordStakeStatus { waiting, playing, finished }

enum LetterStatus { correct, present, absent }

class WordStakeViewModel extends BaseViewModel {
  final SupabaseService _supabaseService = locator<SupabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('WordStakeViewModel');
  final Random _random = Random();

  static const int _maxAttempts = 6;
  static const int _wordLength = 5;
  static const int _gameDuration = 120;

  static const List<String> _wordList = [
    'SWIFT', 'CHAIN', 'BLOCK', 'STAKE', 'PROOF',
    'TOKEN', 'NODES', 'MONEY', 'MINER', 'VAULT',
    'SMART', 'LEDGE', 'CRYPT', 'TRADE', 'YIELD',
    'GRANT', 'FLAME', 'PIXEL', 'STORM', 'BRAVE',
    'CLASH', 'DELTA', 'FORGE', 'GHOST', 'HASTE',
    'INDEX', 'JUICE', 'KNACK', 'LOGIC', 'MARCH',
  ];

  String? _matchId;
  int _stakeAmount = 0;
  bool _isChallenger = true;
  bool _playerSolved = false;
  bool _opponentSolved = false;

  int _timeRemaining = _gameDuration;
  int get timeRemaining => _timeRemaining;

  Timer? _timer;

  String _targetWord = '';
  String get targetWord => _targetWord;

  final List<String> _guesses = [];
  List<String> get guesses => List.unmodifiable(_guesses);

  String _currentGuess = '';
  String get currentGuess => _currentGuess;

  final Map<String, LetterStatus> _letterStatuses = {};
  Map<String, LetterStatus> get letterStatuses =>
      Map.unmodifiable(_letterStatuses);

  int _attempts = 0;
  int get attempts => _attempts;

  final int _opponentAttempts = 0;
  int get opponentAttempts => _opponentAttempts;

  final Map<int, String> _revealedLetters = {};
  Map<int, String> get revealedLetters => Map.unmodifiable(_revealedLetters);

  bool _hintUsed = false;
  bool get hintUsed => _hintUsed;

  List<String> get revealedTemplate => List<String>.generate(
        _wordLength,
        (i) => _revealedLetters[i] ?? '',
      );

  WordStakeStatus _gameStatus = WordStakeStatus.waiting;
  WordStakeStatus get gameStatus => _gameStatus;

  bool _isWinner = false;
  bool get isWinner => _isWinner;

  int get stakeAmount => _stakeAmount;

  int get maxAttempts => _maxAttempts;

  int get wordLength => _wordLength;

  Future<void> initGame({
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
  }) async {
    _matchId = matchId;
    _stakeAmount = stakeAmount;
    // TODO: set from match data when real matchmaking is wired
    _isChallenger = true;
    _logger.i('Word Stake starting — match $matchId');
    if (matchId.isNotEmpty) {
      _supabaseService.subscribeToMatch(matchId, _onMatchUpdate);
      await _resolveTargetWord();
    } else {
      _targetWord = _wordList[_random.nextInt(_wordList.length)];
    }
    _revealInitialLetters();
    _startTimer();
    _gameStatus = WordStakeStatus.playing;
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timeRemaining > 0) {
        _timeRemaining--;
        notifyListeners();
      }
      if (_timeRemaining == 0) _resolveTimeUp();
    });
  }

  void _resolveTimeUp() {
    if (_gameStatus != WordStakeStatus.playing) return;
    if (_playerSolved && !_opponentSolved) {
      _endGame(true);
      return;
    }
    if (_opponentSolved && !_playerSolved) {
      _endGame(false);
      return;
    }
    _endGame(_isChallenger);
  }

  void _revealInitialLetters() {
    if (_targetWord.length != _wordLength) return;
    _revealedLetters.clear();
    final positions = List<int>.generate(_wordLength, (i) => i)
      ..shuffle(_random);
    final first = positions.first;
    final candidates =
        positions.where((p) => (p - first).abs() >= 2).toList();
    final second = candidates.isNotEmpty
        ? candidates.first
        : positions.firstWhere((p) => p != first);
    _revealedLetters[first] = _targetWord[first];
    _revealedLetters[second] = _targetWord[second];
    _logger.d('Revealed hint positions $first and $second');
  }

  void useHint() {
    if (_hintUsed) return;
    if (_gameStatus != WordStakeStatus.playing) return;
    final remaining = List<int>.generate(_wordLength, (i) => i)
        .where((i) => !_revealedLetters.containsKey(i))
        .toList();
    if (remaining.isEmpty) return;
    remaining.shuffle(_random);
    final pos = remaining.first;
    _revealedLetters[pos] = _targetWord[pos];
    _hintUsed = true;
    _logger.i('Hint used — revealed position $pos');
    notifyListeners();
  }

  Future<void> _resolveTargetWord() async {
    try {
      final match = await _supabaseService.getMatch(_matchId!);
      final existing = match['current_target'];
      if (existing is String && existing.length == _wordLength) {
        _targetWord = existing.toUpperCase();
        _logger.d('Joined existing word');
        return;
      }
      _targetWord = _wordList[_random.nextInt(_wordList.length)];
      await _supabaseService.updateMatchState(
        _matchId!,
        {'current_target': _targetWord},
      );
      _logger.d('Published new target word');
    } catch (e, stack) {
      _logger.e('Word resolve failed', error: e, stackTrace: stack);
      _targetWord = _wordList[_random.nextInt(_wordList.length)];
    }
  }

  void onLetterTap(String letter) {
    if (_gameStatus != WordStakeStatus.playing) return;
    if (_currentGuess.length >= _wordLength) return;
    _currentGuess += letter;
    notifyListeners();
  }

  void onDelete() {
    if (_gameStatus != WordStakeStatus.playing) return;
    if (_currentGuess.isEmpty) return;
    _currentGuess = _currentGuess.substring(0, _currentGuess.length - 1);
    notifyListeners();
  }

  Future<void> onSubmit() async {
    if (_gameStatus != WordStakeStatus.playing) return;
    if (_currentGuess.length != _wordLength) return;
    final guess = _currentGuess;
    _guesses.add(guess);
    _attempts++;
    _checkGuess(guess);
    final won = guess == _targetWord;
    if (won) _playerSolved = true;
    _currentGuess = '';
    notifyListeners();
    if (won) await _syncSolved();
    if (won) {
      _endGame(true);
    } else if (_attempts >= _maxAttempts) {
      _endGame(false);
    }
  }

  void _checkGuess(String guess) {
    for (var i = 0; i < guess.length; i++) {
      final ch = guess[i];
      final LetterStatus status;
      if (_targetWord[i] == ch) {
        status = LetterStatus.correct;
      } else if (_targetWord.contains(ch)) {
        status = LetterStatus.present;
      } else {
        status = LetterStatus.absent;
      }
      final existing = _letterStatuses[ch];
      if (existing == null || _isBetter(status, existing)) {
        _letterStatuses[ch] = status;
      }
    }
  }

  bool _isBetter(LetterStatus next, LetterStatus current) {
    if (current == LetterStatus.correct) return false;
    if (next == LetterStatus.correct) return true;
    if (current == LetterStatus.present) return false;
    return next == LetterStatus.present;
  }

  LetterStatus? statusForCell(int row, int col) {
    if (row >= _guesses.length) return null;
    final ch = _guesses[row][col];
    if (_targetWord[col] == ch) return LetterStatus.correct;
    if (_targetWord.contains(ch)) return LetterStatus.present;
    return LetterStatus.absent;
  }

  String letterAtCell(int row, int col) {
    if (row < _guesses.length) return _guesses[row][col];
    if (row == _guesses.length && col < _currentGuess.length) {
      return _currentGuess[col];
    }
    return '';
  }

  void _onMatchUpdate(Map<String, dynamic> update) {
    _logger.d('Match update received');
    final opponentColumn =
        _isChallenger ? 'opponent_score' : 'challenger_score';
    final opponentSolved = (update[opponentColumn] as int? ?? 0) > 0;
    if (opponentSolved && !_opponentSolved) {
      _opponentSolved = true;
      notifyListeners();
    }
    final target = update['current_target'];
    if (target is String &&
        target.length == _wordLength &&
        _targetWord.isEmpty) {
      _targetWord = target.toUpperCase();
      notifyListeners();
    }
    if (opponentSolved &&
        !_playerSolved &&
        _gameStatus == WordStakeStatus.playing) {
      _endGame(false);
    }
  }

  void _endGame(bool playerWon) {
    _timer?.cancel();
    if (_matchId != null && _matchId!.isNotEmpty) {
      _supabaseService.unsubscribeFromMatch(_matchId!);
    }
    _isWinner = playerWon;
    _gameStatus = WordStakeStatus.finished;
    _logger.i('Game ended — playerWon: $playerWon');
    notifyListeners();
  }

  Future<void> _syncSolved() async {
    if (_matchId == null || _matchId!.isEmpty) return;
    try {
      final column = _isChallenger ? 'challenger_score' : 'opponent_score';
      await _supabaseService.updateMatchState(
        _matchId!,
        {column: 1},
      );
    } catch (e, stack) {
      _logger.e('Solve sync failed', error: e, stackTrace: stack);
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
