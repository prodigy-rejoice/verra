import 'package:logger/logger.dart';
import '../app/app.logger.dart';
import '../core/enums/challenge_type.dart';
import '../models/challenge.dart';
import '../models/leaderboard_entry.dart';

class SupabaseService {
  final Logger _logger = getLogger('SupabaseService');

  Future<String> enterMatchmakingQueue({
    required String walletAddress,
    required ChallengeType gameType,
    required int repScore,
  }) async {
    _logger.i('Entering matchmaking queue for $walletAddress');
    throw UnimplementedError();
  }

  Future<void> leaveMatchmakingQueue(String walletAddress) async {
    _logger.i('Leaving matchmaking queue for $walletAddress');
    throw UnimplementedError();
  }

  Stream<Map<String, dynamic>> watchMatch(String matchId) {
    _logger.i('Watching match $matchId');
    throw UnimplementedError();
  }

  Future<List<Challenge>> fetchChallenges(ChallengeType type) async {
    _logger.i('Fetching challenges for ${type.key}');
    throw UnimplementedError();
  }

  Future<List<LeaderboardEntry>> fetchLeaderboard({int limit = 100}) async {
    _logger.i('Fetching leaderboard (limit=$limit)');
    throw UnimplementedError();
  }

  Future<void> queueMatchResult(Map<String, dynamic> resultPayload) async {
    _logger.i('Queueing match result for on-chain submission');
    throw UnimplementedError();
  }
}
