// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i18;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i20;
import 'package:verra/core/enums/challenge_type.dart' as _i19;
import 'package:verra/features/auth/auth_view.dart' as _i4;
import 'package:verra/features/challenge_lobby/challenge_lobby_view.dart'
    as _i10;
import 'package:verra/features/games/chain_reflex/chain_reflex_view.dart'
    as _i12;
import 'package:verra/features/games/crypto_trivia/crypto_trivia_view.dart'
    as _i13;
import 'package:verra/features/games/math_duel/math_duel_view.dart' as _i16;
import 'package:verra/features/games/pattern_breaker/pattern_breaker_view.dart'
    as _i15;
import 'package:verra/features/games/word_stake/word_stake_view.dart' as _i14;
import 'package:verra/features/home/home_view.dart' as _i5;
import 'package:verra/features/leaderboard/leaderboard_view.dart' as _i7;
import 'package:verra/features/match/match_view.dart' as _i11;
import 'package:verra/features/match_result/match_result_view.dart' as _i17;
import 'package:verra/features/onboarding/onboarding_view.dart' as _i3;
import 'package:verra/features/play_mode/play_mode_view.dart' as _i8;
import 'package:verra/features/practice_lobby/practice_lobby_view.dart' as _i9;
import 'package:verra/features/profile/profile_view.dart' as _i6;
import 'package:verra/features/splash/splash_view.dart' as _i2;

class Routes {
  static const splashView = '/';

  static const onboardingView = '/onboarding-view';

  static const authView = '/auth-view';

  static const homeView = '/home-view';

  static const profileView = '/profile-view';

  static const leaderboardView = '/leaderboard-view';

  static const playModeView = '/play-mode-view';

  static const practiceLobbyView = '/practice-lobby-view';

  static const challengeLobbyView = '/challenge-lobby-view';

  static const matchView = '/match-view';

  static const chainReflexView = '/chain-reflex-view';

  static const cryptoTriviaView = '/crypto-trivia-view';

  static const wordStakeView = '/word-stake-view';

  static const patternBreakerView = '/pattern-breaker-view';

  static const mathDuelView = '/math-duel-view';

  static const matchResultView = '/match-result-view';

  static const all = <String>{
    splashView,
    onboardingView,
    authView,
    homeView,
    profileView,
    leaderboardView,
    playModeView,
    practiceLobbyView,
    challengeLobbyView,
    matchView,
    chainReflexView,
    cryptoTriviaView,
    wordStakeView,
    patternBreakerView,
    mathDuelView,
    matchResultView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.splashView, page: _i2.SplashView),
    _i1.RouteDef(Routes.onboardingView, page: _i3.OnboardingView),
    _i1.RouteDef(Routes.authView, page: _i4.AuthView),
    _i1.RouteDef(Routes.homeView, page: _i5.HomeView),
    _i1.RouteDef(Routes.profileView, page: _i6.ProfileView),
    _i1.RouteDef(Routes.leaderboardView, page: _i7.LeaderboardView),
    _i1.RouteDef(Routes.playModeView, page: _i8.PlayModeView),
    _i1.RouteDef(Routes.practiceLobbyView, page: _i9.PracticeLobbyView),
    _i1.RouteDef(Routes.challengeLobbyView, page: _i10.ChallengeLobbyView),
    _i1.RouteDef(Routes.matchView, page: _i11.MatchView),
    _i1.RouteDef(Routes.chainReflexView, page: _i12.ChainReflexView),
    _i1.RouteDef(Routes.cryptoTriviaView, page: _i13.CryptoTriviaView),
    _i1.RouteDef(Routes.wordStakeView, page: _i14.WordStakeView),
    _i1.RouteDef(Routes.patternBreakerView, page: _i15.PatternBreakerView),
    _i1.RouteDef(Routes.mathDuelView, page: _i16.MathDuelView),
    _i1.RouteDef(Routes.matchResultView, page: _i17.MatchResultView),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      final args = data.getArgs<SplashViewArguments>(
        orElse: () => const SplashViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplashView(key: args.key),
        settings: data,
      );
    },
    _i3.OnboardingView: (data) {
      final args = data.getArgs<OnboardingViewArguments>(
        orElse: () => const OnboardingViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.OnboardingView(key: args.key),
        settings: data,
      );
    },
    _i4.AuthView: (data) {
      final args = data.getArgs<AuthViewArguments>(
        orElse: () => const AuthViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.AuthView(key: args.key),
        settings: data,
      );
    },
    _i5.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => const HomeViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.HomeView(key: args.key),
        settings: data,
      );
    },
    _i6.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(
        orElse: () => const ProfileViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.ProfileView(
          key: args.key,
          onPlayPressedOverride: args.onPlayPressedOverride,
        ),
        settings: data,
      );
    },
    _i7.LeaderboardView: (data) {
      final args = data.getArgs<LeaderboardViewArguments>(
        orElse: () => const LeaderboardViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.LeaderboardView(key: args.key),
        settings: data,
      );
    },
    _i8.PlayModeView: (data) {
      final args = data.getArgs<PlayModeViewArguments>(
        orElse: () => const PlayModeViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.PlayModeView(key: args.key),
        settings: data,
      );
    },
    _i9.PracticeLobbyView: (data) {
      final args = data.getArgs<PracticeLobbyViewArguments>(
        orElse: () => const PracticeLobbyViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.PracticeLobbyView(key: args.key),
        settings: data,
      );
    },
    _i10.ChallengeLobbyView: (data) {
      final args = data.getArgs<ChallengeLobbyViewArguments>(
        orElse: () => const ChallengeLobbyViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.ChallengeLobbyView(
          key: args.key,
          initialChallengeType: args.initialChallengeType,
        ),
        settings: data,
      );
    },
    _i11.MatchView: (data) {
      final args = data.getArgs<MatchViewArguments>(
        orElse: () => const MatchViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.MatchView(key: args.key),
        settings: data,
      );
    },
    _i12.ChainReflexView: (data) {
      final args = data.getArgs<ChainReflexViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.ChainReflexView(
          key: args.key,
          matchId: args.matchId,
          playerAddress: args.playerAddress,
          opponentAddress: args.opponentAddress,
          stakeAmount: args.stakeAmount,
          isPractice: args.isPractice,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    _i13.CryptoTriviaView: (data) {
      final args = data.getArgs<CryptoTriviaViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.CryptoTriviaView(
          key: args.key,
          matchId: args.matchId,
          playerAddress: args.playerAddress,
          opponentAddress: args.opponentAddress,
          stakeAmount: args.stakeAmount,
          isPractice: args.isPractice,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    _i14.WordStakeView: (data) {
      final args = data.getArgs<WordStakeViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.WordStakeView(
          key: args.key,
          matchId: args.matchId,
          playerAddress: args.playerAddress,
          opponentAddress: args.opponentAddress,
          stakeAmount: args.stakeAmount,
          isPractice: args.isPractice,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    _i15.PatternBreakerView: (data) {
      final args = data.getArgs<PatternBreakerViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.PatternBreakerView(
          key: args.key,
          matchId: args.matchId,
          playerAddress: args.playerAddress,
          opponentAddress: args.opponentAddress,
          stakeAmount: args.stakeAmount,
          isPractice: args.isPractice,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    _i16.MathDuelView: (data) {
      final args = data.getArgs<MathDuelViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.MathDuelView(
          key: args.key,
          matchId: args.matchId,
          playerAddress: args.playerAddress,
          opponentAddress: args.opponentAddress,
          stakeAmount: args.stakeAmount,
          isPractice: args.isPractice,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    _i17.MatchResultView: (data) {
      final args = data.getArgs<MatchResultViewArguments>(
        orElse: () => const MatchResultViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.MatchResultView(key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class SplashViewArguments {
  const SplashViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SplashViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class OnboardingViewArguments {
  const OnboardingViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant OnboardingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AuthViewArguments {
  const AuthViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AuthViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class HomeViewArguments {
  const HomeViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant HomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ProfileViewArguments {
  const ProfileViewArguments({this.key, this.onPlayPressedOverride});

  final _i18.Key? key;

  final void Function()? onPlayPressedOverride;

  @override
  String toString() {
    return '{"key": "$key", "onPlayPressedOverride": "$onPlayPressedOverride"}';
  }

  @override
  bool operator ==(covariant ProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.onPlayPressedOverride == onPlayPressedOverride;
  }

  @override
  int get hashCode {
    return key.hashCode ^ onPlayPressedOverride.hashCode;
  }
}

class LeaderboardViewArguments {
  const LeaderboardViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LeaderboardViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class PlayModeViewArguments {
  const PlayModeViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PlayModeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class PracticeLobbyViewArguments {
  const PracticeLobbyViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PracticeLobbyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ChallengeLobbyViewArguments {
  const ChallengeLobbyViewArguments({this.key, this.initialChallengeType});

  final _i18.Key? key;

  final _i19.ChallengeType? initialChallengeType;

  @override
  String toString() {
    return '{"key": "$key", "initialChallengeType": "$initialChallengeType"}';
  }

  @override
  bool operator ==(covariant ChallengeLobbyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.initialChallengeType == initialChallengeType;
  }

  @override
  int get hashCode {
    return key.hashCode ^ initialChallengeType.hashCode;
  }
}

class MatchViewArguments {
  const MatchViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant MatchViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ChainReflexViewArguments {
  const ChainReflexViewArguments({
    this.key,
    required this.matchId,
    required this.playerAddress,
    required this.opponentAddress,
    required this.stakeAmount,
    this.isPractice = false,
  });

  final _i18.Key? key;

  final String matchId;

  final String playerAddress;

  final String opponentAddress;

  final int stakeAmount;

  final bool isPractice;

  @override
  String toString() {
    return '{"key": "$key", "matchId": "$matchId", "playerAddress": "$playerAddress", "opponentAddress": "$opponentAddress", "stakeAmount": "$stakeAmount", "isPractice": "$isPractice"}';
  }

  @override
  bool operator ==(covariant ChainReflexViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.matchId == matchId &&
        other.playerAddress == playerAddress &&
        other.opponentAddress == opponentAddress &&
        other.stakeAmount == stakeAmount &&
        other.isPractice == isPractice;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        matchId.hashCode ^
        playerAddress.hashCode ^
        opponentAddress.hashCode ^
        stakeAmount.hashCode ^
        isPractice.hashCode;
  }
}

class CryptoTriviaViewArguments {
  const CryptoTriviaViewArguments({
    this.key,
    required this.matchId,
    required this.playerAddress,
    required this.opponentAddress,
    required this.stakeAmount,
    this.isPractice = false,
  });

  final _i18.Key? key;

  final String matchId;

  final String playerAddress;

  final String opponentAddress;

  final int stakeAmount;

  final bool isPractice;

  @override
  String toString() {
    return '{"key": "$key", "matchId": "$matchId", "playerAddress": "$playerAddress", "opponentAddress": "$opponentAddress", "stakeAmount": "$stakeAmount", "isPractice": "$isPractice"}';
  }

  @override
  bool operator ==(covariant CryptoTriviaViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.matchId == matchId &&
        other.playerAddress == playerAddress &&
        other.opponentAddress == opponentAddress &&
        other.stakeAmount == stakeAmount &&
        other.isPractice == isPractice;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        matchId.hashCode ^
        playerAddress.hashCode ^
        opponentAddress.hashCode ^
        stakeAmount.hashCode ^
        isPractice.hashCode;
  }
}

class WordStakeViewArguments {
  const WordStakeViewArguments({
    this.key,
    required this.matchId,
    required this.playerAddress,
    required this.opponentAddress,
    required this.stakeAmount,
    this.isPractice = false,
  });

  final _i18.Key? key;

  final String matchId;

  final String playerAddress;

  final String opponentAddress;

  final int stakeAmount;

  final bool isPractice;

  @override
  String toString() {
    return '{"key": "$key", "matchId": "$matchId", "playerAddress": "$playerAddress", "opponentAddress": "$opponentAddress", "stakeAmount": "$stakeAmount", "isPractice": "$isPractice"}';
  }

  @override
  bool operator ==(covariant WordStakeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.matchId == matchId &&
        other.playerAddress == playerAddress &&
        other.opponentAddress == opponentAddress &&
        other.stakeAmount == stakeAmount &&
        other.isPractice == isPractice;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        matchId.hashCode ^
        playerAddress.hashCode ^
        opponentAddress.hashCode ^
        stakeAmount.hashCode ^
        isPractice.hashCode;
  }
}

class PatternBreakerViewArguments {
  const PatternBreakerViewArguments({
    this.key,
    required this.matchId,
    required this.playerAddress,
    required this.opponentAddress,
    required this.stakeAmount,
    this.isPractice = false,
  });

  final _i18.Key? key;

  final String matchId;

  final String playerAddress;

  final String opponentAddress;

  final int stakeAmount;

  final bool isPractice;

  @override
  String toString() {
    return '{"key": "$key", "matchId": "$matchId", "playerAddress": "$playerAddress", "opponentAddress": "$opponentAddress", "stakeAmount": "$stakeAmount", "isPractice": "$isPractice"}';
  }

  @override
  bool operator ==(covariant PatternBreakerViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.matchId == matchId &&
        other.playerAddress == playerAddress &&
        other.opponentAddress == opponentAddress &&
        other.stakeAmount == stakeAmount &&
        other.isPractice == isPractice;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        matchId.hashCode ^
        playerAddress.hashCode ^
        opponentAddress.hashCode ^
        stakeAmount.hashCode ^
        isPractice.hashCode;
  }
}

class MathDuelViewArguments {
  const MathDuelViewArguments({
    this.key,
    required this.matchId,
    required this.playerAddress,
    required this.opponentAddress,
    required this.stakeAmount,
    this.isPractice = false,
  });

  final _i18.Key? key;

  final String matchId;

  final String playerAddress;

  final String opponentAddress;

  final int stakeAmount;

  final bool isPractice;

  @override
  String toString() {
    return '{"key": "$key", "matchId": "$matchId", "playerAddress": "$playerAddress", "opponentAddress": "$opponentAddress", "stakeAmount": "$stakeAmount", "isPractice": "$isPractice"}';
  }

  @override
  bool operator ==(covariant MathDuelViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.matchId == matchId &&
        other.playerAddress == playerAddress &&
        other.opponentAddress == opponentAddress &&
        other.stakeAmount == stakeAmount &&
        other.isPractice == isPractice;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        matchId.hashCode ^
        playerAddress.hashCode ^
        opponentAddress.hashCode ^
        stakeAmount.hashCode ^
        isPractice.hashCode;
  }
}

class MatchResultViewArguments {
  const MatchResultViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant MatchResultViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

extension NavigatorStateExtension on _i20.NavigationService {
  Future<dynamic> navigateToSplashView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.splashView,
      arguments: SplashViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToOnboardingView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.onboardingView,
      arguments: OnboardingViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToAuthView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.authView,
      arguments: AuthViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToHomeView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.homeView,
      arguments: HomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToProfileView({
    _i18.Key? key,
    void Function()? onPlayPressedOverride,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.profileView,
      arguments: ProfileViewArguments(
        key: key,
        onPlayPressedOverride: onPlayPressedOverride,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLeaderboardView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.leaderboardView,
      arguments: LeaderboardViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPlayModeView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.playModeView,
      arguments: PlayModeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPracticeLobbyView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.practiceLobbyView,
      arguments: PracticeLobbyViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToChallengeLobbyView({
    _i18.Key? key,
    _i19.ChallengeType? initialChallengeType,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.challengeLobbyView,
      arguments: ChallengeLobbyViewArguments(
        key: key,
        initialChallengeType: initialChallengeType,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToMatchView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.matchView,
      arguments: MatchViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToChainReflexView({
    _i18.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.chainReflexView,
      arguments: ChainReflexViewArguments(
        key: key,
        matchId: matchId,
        playerAddress: playerAddress,
        opponentAddress: opponentAddress,
        stakeAmount: stakeAmount,
        isPractice: isPractice,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToCryptoTriviaView({
    _i18.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.cryptoTriviaView,
      arguments: CryptoTriviaViewArguments(
        key: key,
        matchId: matchId,
        playerAddress: playerAddress,
        opponentAddress: opponentAddress,
        stakeAmount: stakeAmount,
        isPractice: isPractice,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToWordStakeView({
    _i18.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.wordStakeView,
      arguments: WordStakeViewArguments(
        key: key,
        matchId: matchId,
        playerAddress: playerAddress,
        opponentAddress: opponentAddress,
        stakeAmount: stakeAmount,
        isPractice: isPractice,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPatternBreakerView({
    _i18.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.patternBreakerView,
      arguments: PatternBreakerViewArguments(
        key: key,
        matchId: matchId,
        playerAddress: playerAddress,
        opponentAddress: opponentAddress,
        stakeAmount: stakeAmount,
        isPractice: isPractice,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToMathDuelView({
    _i18.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.mathDuelView,
      arguments: MathDuelViewArguments(
        key: key,
        matchId: matchId,
        playerAddress: playerAddress,
        opponentAddress: opponentAddress,
        stakeAmount: stakeAmount,
        isPractice: isPractice,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToMatchResultView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.matchResultView,
      arguments: MatchResultViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSplashView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.splashView,
      arguments: SplashViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithOnboardingView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.onboardingView,
      arguments: OnboardingViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithAuthView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.authView,
      arguments: AuthViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithHomeView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.homeView,
      arguments: HomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithProfileView({
    _i18.Key? key,
    void Function()? onPlayPressedOverride,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.profileView,
      arguments: ProfileViewArguments(
        key: key,
        onPlayPressedOverride: onPlayPressedOverride,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithLeaderboardView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.leaderboardView,
      arguments: LeaderboardViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPlayModeView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.playModeView,
      arguments: PlayModeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPracticeLobbyView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.practiceLobbyView,
      arguments: PracticeLobbyViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithChallengeLobbyView({
    _i18.Key? key,
    _i19.ChallengeType? initialChallengeType,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.challengeLobbyView,
      arguments: ChallengeLobbyViewArguments(
        key: key,
        initialChallengeType: initialChallengeType,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithMatchView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.matchView,
      arguments: MatchViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithChainReflexView({
    _i18.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.chainReflexView,
      arguments: ChainReflexViewArguments(
        key: key,
        matchId: matchId,
        playerAddress: playerAddress,
        opponentAddress: opponentAddress,
        stakeAmount: stakeAmount,
        isPractice: isPractice,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithCryptoTriviaView({
    _i18.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.cryptoTriviaView,
      arguments: CryptoTriviaViewArguments(
        key: key,
        matchId: matchId,
        playerAddress: playerAddress,
        opponentAddress: opponentAddress,
        stakeAmount: stakeAmount,
        isPractice: isPractice,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithWordStakeView({
    _i18.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.wordStakeView,
      arguments: WordStakeViewArguments(
        key: key,
        matchId: matchId,
        playerAddress: playerAddress,
        opponentAddress: opponentAddress,
        stakeAmount: stakeAmount,
        isPractice: isPractice,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPatternBreakerView({
    _i18.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.patternBreakerView,
      arguments: PatternBreakerViewArguments(
        key: key,
        matchId: matchId,
        playerAddress: playerAddress,
        opponentAddress: opponentAddress,
        stakeAmount: stakeAmount,
        isPractice: isPractice,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithMathDuelView({
    _i18.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
    bool isPractice = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.mathDuelView,
      arguments: MathDuelViewArguments(
        key: key,
        matchId: matchId,
        playerAddress: playerAddress,
        opponentAddress: opponentAddress,
        stakeAmount: stakeAmount,
        isPractice: isPractice,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithMatchResultView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.matchResultView,
      arguments: MatchResultViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
