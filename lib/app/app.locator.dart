// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_services/src/snackbar/snackbar_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../repositories/challenge_repository.dart';
import '../repositories/leaderboard_repository.dart';
import '../repositories/match_repository.dart';
import '../repositories/player_repository.dart';
import '../services/sponsored_tx_service.dart';
import '../services/sui_service.dart';
import '../services/supabase_service.dart';
import '../services/walrus_service.dart';
import '../services/zklogin_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  // Register environments
  locator.registerEnvironment(
    environment: environment,
    environmentFilter: environmentFilter,
  );

  // Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => SuiService());
  locator.registerLazySingleton(() => ZkLoginService());
  locator.registerLazySingleton(() => SupabaseService());
  locator.registerLazySingleton(() => WalrusService());
  locator.registerLazySingleton(() => SponsoredTxService());
  locator.registerLazySingleton(() => PlayerRepository());
  locator.registerLazySingleton(() => MatchRepository());
  locator.registerLazySingleton(() => LeaderboardRepository());
  locator.registerLazySingleton(() => ChallengeRepository());
}
