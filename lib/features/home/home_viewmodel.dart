import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../core/constants/sui_constants.dart';
import '../../core/enums/challenge_type.dart';
import '../../core/enums/player_rank.dart';
import '../../core/extensions/string_extensions.dart';
import '../../models/player_profile.dart';
import '../../repositories/player_repository.dart';

enum HomeTab { play, leaderboard, profile }

class HomeViewModel extends BaseViewModel {
  final PlayerRepository _playerRepository = locator<PlayerRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('HomeViewModel');

  static const String _walletAddressKey = 'verra_wallet_address';

  HomeTab _activeTab = HomeTab.play;
  HomeTab get activeTab => _activeTab;

  PlayerProfile? _profile;
  PlayerProfile? get profile => _profile;

  String? _walletAddress;
  String? get walletAddress => _walletAddress;

  String get displayName {
    final name = _profile?.displayName;
    if (name != null && name.isNotEmpty) return name;
    return _walletAddress?.shortAddress ?? '';
  }

  int get currentRankMinScore {
    switch (_profile?.rank) {
      case PlayerRank.rookie:
      case null:
        return SuiConstants.repScoreFloor;
      case PlayerRank.bronze:
        return SuiConstants.rankRookieMax + 1;
      case PlayerRank.silver:
        return SuiConstants.rankBronzeMax + 1;
      case PlayerRank.gold:
        return SuiConstants.rankSilverMax + 1;
      case PlayerRank.legend:
        return SuiConstants.rankGoldMax + 1;
    }
  }

  int? get nextRankMinScore {
    switch (_profile?.rank) {
      case PlayerRank.rookie:
        return SuiConstants.rankRookieMax + 1;
      case PlayerRank.bronze:
        return SuiConstants.rankBronzeMax + 1;
      case PlayerRank.silver:
        return SuiConstants.rankSilverMax + 1;
      case PlayerRank.gold:
        return SuiConstants.rankGoldMax + 1;
      case PlayerRank.legend:
      case null:
        return null;
    }
  }

  String? get nextRankName {
    final rank = _profile?.rank;
    if (rank == null || rank == PlayerRank.legend) return null;
    return PlayerRank.values[rank.index + 1].displayName;
  }

  double get rankProgress {
    final profile = _profile;
    if (profile == null) return 0.0;
    if (profile.rank == PlayerRank.legend) return 1.0;
    final next = nextRankMinScore!;
    final current = currentRankMinScore;
    final span = next - current;
    if (span <= 0) return 1.0;
    return ((profile.repScore - current) / span).clamp(0.0, 1.0);
  }

  Map<String, String> get dailyChallenge {
    switch (DateTime.now().weekday) {
      case DateTime.monday:
        return const {
          'type': 'Crypto Trivia',
          'label': 'Knowledge Monday',
          'description': 'Test your Web3 knowledge',
          'bonus': '+ 50 bonus REP',
        };
      case DateTime.tuesday:
        return const {
          'type': 'Math Duel',
          'label': 'Mental Math Tuesday',
          'description': 'Calculate faster than your opponent',
          'bonus': '+ 40 bonus REP',
        };
      case DateTime.wednesday:
        return const {
          'type': 'Word Stake',
          'label': 'Word Wednesday',
          'description': 'Guess the word before they do',
          'bonus': '+ 45 bonus REP',
        };
      case DateTime.thursday:
        return const {
          'type': 'Pattern Breaker',
          'label': 'Think Thursday',
          'description': 'Spot the pattern, beat the clock',
          'bonus': '+ 40 bonus REP',
        };
      case DateTime.friday:
        return const {
          'type': 'Chain Reflex',
          'label': 'Fast Friday',
          'description': 'Reaction speed championship',
          'bonus': '+ 60 bonus REP',
        };
      case DateTime.saturday:
        return const {
          'type': 'Crypto Trivia',
          'label': 'Weekend Warriors',
          'description': 'Who knows crypto best?',
          'bonus': '+ 55 bonus REP',
        };
      default:
        return const {
          'type': 'Math Duel',
          'label': 'Sunday Showdown',
          'description': 'End the week with a duel',
          'bonus': '+ 50 bonus REP',
        };
    }
  }

  void setActiveTab(HomeTab tab) {
    if (_activeTab == tab) return;
    _activeTab = tab;
    notifyListeners();
  }

  void switchToPlayTab() => setActiveTab(HomeTab.play);

  Future<void> init() async {
    _logger.i('Home initialized');
    await _loadProfile();
  }

  Future<void> _loadProfile() async {
    setBusy(true);
    try {
      _walletAddress = await _readSavedWalletAddress();
      if (_walletAddress != null) {
        _profile = await _playerRepository.getProfile(_walletAddress!) ??
            _fallbackProfile(_walletAddress!);
        _logger.d('Profile loaded — rep ${_profile?.repScore}');
      }
      notifyListeners();
    } catch (e, stack) {
      _logger.e('Home profile load error', error: e, stackTrace: stack);
      if (_walletAddress != null) {
        _profile = _fallbackProfile(_walletAddress!);
        notifyListeners();
      }
    } finally {
      setBusy(false);
    }
  }

  PlayerProfile _fallbackProfile(String walletAddress) => PlayerProfile(
        walletAddress: walletAddress,
        repScore: SuiConstants.startingRepScore,
        wins: 0,
        losses: 0,
        challengesCompleted: 0,
      );

  Future<void> refresh() => _loadProfile();

  Future<void> navigateToPracticeLobby() async {
    _logger.i('Navigating to practice lobby');
    await _navigationService.navigateTo(Routes.practiceLobbyView);
  }

  Future<void> navigateToPlayOnline() async {
    _logger.i('Navigating to challenge lobby');
    await _navigationService.navigateTo(Routes.challengeLobbyView);
  }

  Future<void> onDailyChallengeTap() async {
    final typeName = dailyChallenge['type'];
    _logger.i('Daily challenge tapped — $typeName');
    final challengeType = ChallengeType.values.firstWhere(
      (t) => t.displayName == typeName,
      orElse: () => ChallengeType.cryptoTrivia,
    );
    await _navigationService.navigateToChallengeLobbyView(
      initialChallengeType: challengeType,
    );
  }

  Future<String?> _readSavedWalletAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_walletAddressKey);
  }
}
