class SuiConstants {
  SuiConstants._();

  static const String networkTestnet = 'testnet';
  static const String networkMainnet = 'mainnet';

  static const String testnetRpcUrl = 'https://fullnode.testnet.sui.io:443';
  static const String mainnetRpcUrl = 'https://fullnode.mainnet.sui.io:443';

  static const String moduleProfile = 'profile';
  static const String moduleMatch = 'match';
  static const String moduleRegistry = 'registry';

  static const String fnCreateProfile = 'create_profile';
  static const String fnSubmitResult = 'submit_result';
  static const String fnRegisterGame = 'register_game';
  static const String fnGetScore = 'get_score';

  static const int startingRepScore = 1000;
  static const int floorRepScore = 100;
  static const int maxStakePercent = 20;

  static const int rankRookieMax = 1099;
  static const int rankBronzeMax = 1299;
  static const int rankSilverMax = 1599;
  static const int rankGoldMax = 1999;

  static const Duration matchTimeout = Duration(seconds: 60);
  static const Duration matchmakingTimeout = Duration(seconds: 30);
}
