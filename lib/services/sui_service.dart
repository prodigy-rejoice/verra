import 'package:logger/logger.dart';
import '../app/app.logger.dart';
import '../models/match_record.dart';
import '../models/player_profile.dart';

class SuiService {
  final Logger _logger = getLogger('SuiService');

  Future<PlayerProfile> getPlayerProfile(String walletAddress) async {
    _logger.i('Fetching on-chain profile for $walletAddress');
    // TEST STUB — replace with real Sui object read via package call.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return PlayerProfile(
      walletAddress: walletAddress,
      repScore: 1450,
      wins: 12,
      losses: 7,
      challengesCompleted: 24,
    );
  }

  Future<String> createPlayerProfile(String walletAddress) async {
    _logger.i('Creating on-chain profile for $walletAddress');
    throw UnimplementedError();
  }

  Future<String> submitMatchResult({
    required String winnerAddress,
    required String loserAddress,
    required int stake,
    required String gameType,
  }) async {
    _logger.i('Submitting match result: winner=$winnerAddress stake=$stake');
    throw UnimplementedError();
  }

  Future<String> stakeReputation(String walletAddress, int amount) async {
    _logger.i('Staking $amount rep from $walletAddress');
    throw UnimplementedError();
  }

  Future<List<MatchRecord>> getMatchHistory(String walletAddress) async {
    _logger.i('Fetching match history for $walletAddress');
    throw UnimplementedError();
  }
}
