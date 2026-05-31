class SuiConstants {
  SuiConstants._();

  static const String testnetRpcUrl = 'https://fullnode.testnet.sui.io:443';

  static const String packageId = String.fromEnvironment('VERRA_PACKAGE_ID');
  static const String gameRegistryId =
      String.fromEnvironment('VERRA_GAME_REGISTRY_ID');
  static const String deployerAddress =
      String.fromEnvironment('VERRA_DEPLOYER_ADDRESS');

  static const int startingRepScore = 1000;
  static const int repScoreFloor = 100;
  static const double maxStakePercent = 0.20;

  static const int rankRookieMax = 1099;
  static const int rankBronzeMax = 1299;
  static const int rankSilverMax = 1599;
  static const int rankGoldMax = 1999;

  static const String playerProfileType = '$packageId::verra::PlayerProfile';
  static const String matchRecordType = '$packageId::verra::MatchRecord';
  static const String gameCapType = '$packageId::verra::GameCap';
}
