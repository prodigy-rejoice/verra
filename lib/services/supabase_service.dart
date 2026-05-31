import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../app/app.logger.dart';
import '../core/enums/challenge_type.dart';
import '../core/exceptions/verra_exception.dart';
import '../models/challenge.dart';
import '../models/leaderboard_entry.dart';

class SupabaseService {
  final Logger _logger = getLogger('SupabaseService');
  final Map<String, RealtimeChannel> _channels = {};

  SupabaseClient get _client => Supabase.instance.client;

  Future<void> initialize() async {
    _logger.i('Initializing Supabase');
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
    _logger.d('Supabase initialized');
  }

  Future<String> createMatch(
    String challengerAddress,
    String opponentAddress,
    int stakeAmount,
    String challengeType,
  ) async {
    _logger.i('Creating match: $challengerAddress vs $opponentAddress');
    try {
      final response = await _client
          .from('matches')
          .insert({
            'challenger_address': challengerAddress,
            'opponent_address': opponentAddress,
            'stake_amount': stakeAmount,
            'challenge_type': challengeType,
            'status': 'waiting',
            'challenger_score': 0,
            'opponent_score': 0,
          })
          .select('id')
          .single();
      final matchId = response['id'] as String;
      _logger.d('Match created — id $matchId');
      return matchId;
    } catch (e, stack) {
      _logger.e('Failed to create match', error: e, stackTrace: stack);
      throw VerraException('Unable to create match.', cause: e);
    }
  }

  void subscribeToMatch(
    String matchId,
    void Function(Map<String, dynamic>) onUpdate,
  ) {
    _logger.i('Subscribing to match $matchId');
    final channel = _client
        .channel('match_$matchId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'matches',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: matchId,
          ),
          callback: (payload) => onUpdate(payload.newRecord),
        )
        .subscribe();
    _channels[matchId] = channel;
  }

  Future<void> updateMatchState(
    String matchId,
    Map<String, dynamic> state,
  ) async {
    _logger.i('Updating match $matchId');
    try {
      await _client.from('matches').update(state).eq('id', matchId);
    } catch (e, stack) {
      _logger.e('Failed to update match state', error: e, stackTrace: stack);
      throw VerraException('Unable to update match.', cause: e);
    }
  }

  Future<void> unsubscribeFromMatch(String matchId) async {
    _logger.i('Unsubscribing from match $matchId');
    final channel = _channels.remove(matchId);
    if (channel != null) await _client.removeChannel(channel);
  }

  Future<Map<String, dynamic>> getMatch(String matchId) async {
    _logger.i('Fetching match $matchId');
    try {
      return await _client
          .from('matches')
          .select()
          .eq('id', matchId)
          .single();
    } catch (e, stack) {
      _logger.e('Failed to fetch match', error: e, stackTrace: stack);
      throw VerraException('Unable to fetch match.', cause: e);
    }
  }

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
