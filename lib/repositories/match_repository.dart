import 'package:logger/logger.dart';
import '../app/app.locator.dart';
import '../app/app.logger.dart';
import '../core/enums/challenge_type.dart';
import '../core/exceptions/verra_exception.dart';
import '../models/match_record.dart';
import '../services/sponsored_tx_service.dart';
import '../services/sui_service.dart';
import '../services/supabase_service.dart';

class MatchRepository {
  final SuiService _suiService = locator<SuiService>();
  final SupabaseService _supabaseService = locator<SupabaseService>();
  final SponsoredTxService _sponsoredTxService = locator<SponsoredTxService>();
  final Logger _logger = getLogger('MatchRepository');

  Future<List<MatchRecord>> getHistory(String walletAddress) async {
    _logger.i('Fetching match history for $walletAddress');
    try {
      return await _suiService.getMatchHistory(walletAddress);
    } on VerraException {
      rethrow;
    } catch (e, stack) {
      _logger.e('Failed to fetch match history', error: e, stackTrace: stack);
      throw VerraException('Unable to load match history.', cause: e);
    }
  }

  Future<String> submitResult({
    required String winnerAddress,
    required String loserAddress,
    required int stake,
    required ChallengeType gameType,
  }) async {
    _logger.i('Submitting match result winner=$winnerAddress stake=$stake');
    try {
      await _sponsoredTxService.isSponsorAvailable();
      return await _suiService.submitMatchResult(
        winnerAddress: winnerAddress,
        loserAddress: loserAddress,
        stake: stake,
        gameType: gameType.key,
      );
    } on VerraException {
      rethrow;
    } catch (e, stack) {
      _logger.e('Failed to submit match result', error: e, stackTrace: stack);
      throw VerraException('Unable to submit match result.', cause: e);
    }
  }

  Future<String> findMatch({
    required String walletAddress,
    required ChallengeType gameType,
    required int repScore,
  }) async {
    _logger.i('Entering matchmaking for $walletAddress');
    try {
      return await _supabaseService.enterMatchmakingQueue(
        walletAddress: walletAddress,
        gameType: gameType,
        repScore: repScore,
      );
    } on VerraException {
      rethrow;
    } catch (e, stack) {
      _logger.e('Failed to enter matchmaking', error: e, stackTrace: stack);
      throw VerraException('Unable to find a match.', cause: e);
    }
  }
}
