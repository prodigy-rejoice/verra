import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../features/auth/auth_view.dart';
import '../features/challenge_lobby/challenge_lobby_view.dart';
import '../features/games/chain_reflex/chain_reflex_view.dart';
import '../features/games/crypto_trivia/crypto_trivia_view.dart';
import '../features/games/math_duel/math_duel_view.dart';
import '../features/games/pattern_breaker/pattern_breaker_view.dart';
import '../features/games/word_stake/word_stake_view.dart';
import '../features/home/home_view.dart';
import '../features/leaderboard/leaderboard_view.dart';
import '../features/match/match_view.dart';
import '../features/match_result/match_result_view.dart';
import '../features/onboarding/onboarding_view.dart';
import '../features/profile/profile_view.dart';
import '../features/splash/splash_view.dart';

import '../repositories/challenge_repository.dart';
import '../repositories/leaderboard_repository.dart';
import '../repositories/match_repository.dart';
import '../repositories/player_repository.dart';

import '../services/sponsored_tx_service.dart';
import '../services/sui_service.dart';
import '../services/supabase_service.dart';
import '../services/walrus_service.dart';
import '../services/zklogin_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: LeaderboardView),
    MaterialRoute(page: ChallengeLobbyView),
    MaterialRoute(page: MatchView),
    MaterialRoute(page: ChainReflexView, fullscreenDialog: true),
    MaterialRoute(page: CryptoTriviaView, fullscreenDialog: true),
    MaterialRoute(page: WordStakeView, fullscreenDialog: true),
    MaterialRoute(page: PatternBreakerView, fullscreenDialog: true),
    MaterialRoute(page: MathDuelView, fullscreenDialog: true),
    MaterialRoute(page: MatchResultView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SuiService),
    LazySingleton(classType: ZkLoginService),
    LazySingleton(classType: SupabaseService),
    LazySingleton(classType: WalrusService),
    LazySingleton(classType: SponsoredTxService),
    LazySingleton(classType: PlayerRepository),
    LazySingleton(classType: MatchRepository),
    LazySingleton(classType: LeaderboardRepository),
    LazySingleton(classType: ChallengeRepository),
  ],
  logger: StackedLogger(),
)
class App {}
