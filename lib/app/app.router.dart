// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i16;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i17;
import 'package:verra/features/auth/auth_view.dart' as _i4;
import 'package:verra/features/challenge_lobby/challenge_lobby_view.dart'
    as _i8;
import 'package:verra/features/games/chain_reflex/chain_reflex_view.dart'
    as _i10;
import 'package:verra/features/games/crypto_trivia/crypto_trivia_view.dart'
    as _i11;
import 'package:verra/features/games/math_duel/math_duel_view.dart' as _i14;
import 'package:verra/features/games/pattern_breaker/pattern_breaker_view.dart'
    as _i13;
import 'package:verra/features/games/word_stake/word_stake_view.dart' as _i12;
import 'package:verra/features/home/home_view.dart' as _i5;
import 'package:verra/features/leaderboard/leaderboard_view.dart' as _i7;
import 'package:verra/features/match/match_view.dart' as _i9;
import 'package:verra/features/match_result/match_result_view.dart' as _i15;
import 'package:verra/features/onboarding/onboarding_view.dart' as _i3;
import 'package:verra/features/profile/profile_view.dart' as _i6;
import 'package:verra/features/splash/splash_view.dart' as _i2;

class Routes {
  static const splashView = '/';

  static const onboardingView = '/onboarding-view';

  static const authView = '/auth-view';

  static const homeView = '/home-view';

  static const profileView = '/profile-view';

  static const leaderboardView = '/leaderboard-view';

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
    _i1.RouteDef(Routes.challengeLobbyView, page: _i8.ChallengeLobbyView),
    _i1.RouteDef(Routes.matchView, page: _i9.MatchView),
    _i1.RouteDef(Routes.chainReflexView, page: _i10.ChainReflexView),
    _i1.RouteDef(Routes.cryptoTriviaView, page: _i11.CryptoTriviaView),
    _i1.RouteDef(Routes.wordStakeView, page: _i12.WordStakeView),
    _i1.RouteDef(Routes.patternBreakerView, page: _i13.PatternBreakerView),
    _i1.RouteDef(Routes.mathDuelView, page: _i14.MathDuelView),
    _i1.RouteDef(Routes.matchResultView, page: _i15.MatchResultView),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      final args = data.getArgs<SplashViewArguments>(
        orElse: () => const SplashViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplashView(key: args.key),
        settings: data,
      );
    },
    _i3.OnboardingView: (data) {
      final args = data.getArgs<OnboardingViewArguments>(
        orElse: () => const OnboardingViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.OnboardingView(key: args.key),
        settings: data,
      );
    },
    _i4.AuthView: (data) {
      final args = data.getArgs<AuthViewArguments>(
        orElse: () => const AuthViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.AuthView(key: args.key),
        settings: data,
      );
    },
    _i5.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => const HomeViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.HomeView(key: args.key),
        settings: data,
      );
    },
    _i6.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(
        orElse: () => const ProfileViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
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
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.LeaderboardView(key: args.key),
        settings: data,
      );
    },
    _i8.ChallengeLobbyView: (data) {
      final args = data.getArgs<ChallengeLobbyViewArguments>(
        orElse: () => const ChallengeLobbyViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.ChallengeLobbyView(key: args.key),
        settings: data,
      );
    },
    _i9.MatchView: (data) {
      final args = data.getArgs<MatchViewArguments>(
        orElse: () => const MatchViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.MatchView(key: args.key),
        settings: data,
      );
    },
    _i10.ChainReflexView: (data) {
      final args = data.getArgs<ChainReflexViewArguments>(nullOk: false);
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.ChainReflexView(
          key: args.key,
          matchId: args.matchId,
          playerAddress: args.playerAddress,
          opponentAddress: args.opponentAddress,
          stakeAmount: args.stakeAmount,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    _i11.CryptoTriviaView: (data) {
      final args = data.getArgs<CryptoTriviaViewArguments>(
        orElse: () => const CryptoTriviaViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.CryptoTriviaView(key: args.key),
        settings: data,
      );
    },
    _i12.WordStakeView: (data) {
      final args = data.getArgs<WordStakeViewArguments>(
        orElse: () => const WordStakeViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.WordStakeView(key: args.key),
        settings: data,
      );
    },
    _i13.PatternBreakerView: (data) {
      final args = data.getArgs<PatternBreakerViewArguments>(
        orElse: () => const PatternBreakerViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.PatternBreakerView(key: args.key),
        settings: data,
      );
    },
    _i14.MathDuelView: (data) {
      final args = data.getArgs<MathDuelViewArguments>(
        orElse: () => const MathDuelViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.MathDuelView(key: args.key),
        settings: data,
      );
    },
    _i15.MatchResultView: (data) {
      final args = data.getArgs<MatchResultViewArguments>(
        orElse: () => const MatchResultViewArguments(),
      );
      return _i16.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.MatchResultView(key: args.key),
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

  final _i16.Key? key;

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

  final _i16.Key? key;

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

  final _i16.Key? key;

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

  final _i16.Key? key;

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

  final _i16.Key? key;

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

  final _i16.Key? key;

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

class ChallengeLobbyViewArguments {
  const ChallengeLobbyViewArguments({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ChallengeLobbyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class MatchViewArguments {
  const MatchViewArguments({this.key});

  final _i16.Key? key;

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
  });

  final _i16.Key? key;

  final String matchId;

  final String playerAddress;

  final String opponentAddress;

  final int stakeAmount;

  @override
  String toString() {
    return '{"key": "$key", "matchId": "$matchId", "playerAddress": "$playerAddress", "opponentAddress": "$opponentAddress", "stakeAmount": "$stakeAmount"}';
  }

  @override
  bool operator ==(covariant ChainReflexViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.matchId == matchId &&
        other.playerAddress == playerAddress &&
        other.opponentAddress == opponentAddress &&
        other.stakeAmount == stakeAmount;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        matchId.hashCode ^
        playerAddress.hashCode ^
        opponentAddress.hashCode ^
        stakeAmount.hashCode;
  }
}

class CryptoTriviaViewArguments {
  const CryptoTriviaViewArguments({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant CryptoTriviaViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class WordStakeViewArguments {
  const WordStakeViewArguments({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant WordStakeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class PatternBreakerViewArguments {
  const PatternBreakerViewArguments({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PatternBreakerViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class MathDuelViewArguments {
  const MathDuelViewArguments({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant MathDuelViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class MatchResultViewArguments {
  const MatchResultViewArguments({this.key});

  final _i16.Key? key;

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

extension NavigatorStateExtension on _i17.NavigationService {
  Future<dynamic> navigateToSplashView({
    _i16.Key? key,
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
    _i16.Key? key,
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
    _i16.Key? key,
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
    _i16.Key? key,
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
    _i16.Key? key,
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
    _i16.Key? key,
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

  Future<dynamic> navigateToChallengeLobbyView({
    _i16.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.challengeLobbyView,
      arguments: ChallengeLobbyViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToMatchView({
    _i16.Key? key,
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
    _i16.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
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
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToCryptoTriviaView({
    _i16.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.cryptoTriviaView,
      arguments: CryptoTriviaViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToWordStakeView({
    _i16.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.wordStakeView,
      arguments: WordStakeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPatternBreakerView({
    _i16.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.patternBreakerView,
      arguments: PatternBreakerViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToMathDuelView({
    _i16.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.mathDuelView,
      arguments: MathDuelViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToMatchResultView({
    _i16.Key? key,
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
    _i16.Key? key,
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
    _i16.Key? key,
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
    _i16.Key? key,
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
    _i16.Key? key,
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
    _i16.Key? key,
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
    _i16.Key? key,
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

  Future<dynamic> replaceWithChallengeLobbyView({
    _i16.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.challengeLobbyView,
      arguments: ChallengeLobbyViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithMatchView({
    _i16.Key? key,
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
    _i16.Key? key,
    required String matchId,
    required String playerAddress,
    required String opponentAddress,
    required int stakeAmount,
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
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithCryptoTriviaView({
    _i16.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.cryptoTriviaView,
      arguments: CryptoTriviaViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithWordStakeView({
    _i16.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.wordStakeView,
      arguments: WordStakeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPatternBreakerView({
    _i16.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.patternBreakerView,
      arguments: PatternBreakerViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithMathDuelView({
    _i16.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.mathDuelView,
      arguments: MathDuelViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithMatchResultView({
    _i16.Key? key,
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
