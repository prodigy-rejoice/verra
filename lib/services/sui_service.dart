import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../app/app.logger.dart';
import '../core/constants/sui_constants.dart';
import '../core/enums/challenge_type.dart';
import '../core/exceptions/verra_exception.dart';
import '../models/match_record.dart';
import '../models/player_profile.dart';

class SuiService {
  final Logger _logger = getLogger('SuiService');
  final Dio _dio = Dio(BaseOptions(baseUrl: SuiConstants.testnetRpcUrl));

  Future<PlayerProfile> getPlayerProfile(String walletAddress) async {
    _logger.i('Fetching on-chain profile for $walletAddress');
    try {
      final owned = await _rpcCall('suix_getOwnedObjects', [
        walletAddress,
        {
          'filter': {'StructType': SuiConstants.playerProfileType},
          'options': {'showContent': true},
        },
        null,
        1,
      ]);
      final data = owned['data'] as List<dynamic>? ?? [];
      if (data.isEmpty) {
        throw const SuiException('No profile found on-chain.');
      }
      final objectId =
          (data.first as Map<String, dynamic>)['data']['objectId'] as String;
      return _fetchProfile(objectId, walletAddress);
    } on VerraException {
      rethrow;
    } catch (e, stack) {
      _logger.e('Failed to fetch profile', error: e, stackTrace: stack);
      throw SuiException('Failed to read player profile.', cause: e);
    }
  }

  Future<PlayerProfile> _fetchProfile(
    String objectId,
    String walletAddress,
  ) async {
    final result = await _rpcCall('sui_getObject', [
      objectId,
      {'showContent': true},
    ]);
    final f = _extractFields(result);
    return PlayerProfile(
      walletAddress: walletAddress,
      repScore: int.parse(f['rep_score'].toString()),
      wins: int.parse(f['wins'].toString()),
      losses: int.parse(f['losses'].toString()),
      challengesCompleted: int.parse(f['challenges_completed'].toString()),
    );
  }

  Future<List<MatchRecord>> getMatchHistory(String walletAddress) async {
    _logger.i('Fetching match history for $walletAddress');
    try {
      final owned = await _rpcCall('suix_getOwnedObjects', [
        walletAddress,
        {
          'filter': {'StructType': SuiConstants.matchRecordType},
          'options': {'showContent': true},
        },
        null,
        50,
      ]);
      final data = owned['data'] as List<dynamic>? ?? [];
      return data.map((item) {
        final obj =
            (item as Map<String, dynamic>)['data'] as Map<String, dynamic>;
        final content = obj['content'] as Map<String, dynamic>;
        final f = content['fields'] as Map<String, dynamic>;
        return _parseMatchRecord(obj['objectId'] as String, f);
      }).toList();
    } on VerraException {
      rethrow;
    } catch (e, stack) {
      _logger.e('Failed to fetch match history', error: e, stackTrace: stack);
      throw SuiException('Failed to read match history.', cause: e);
    }
  }

  MatchRecord _parseMatchRecord(String objectId, Map<String, dynamic> f) {
    final typeIndex = int.parse(f['game_type'].toString());
    final epochSec = int.parse(f['timestamp'].toString());
    return MatchRecord(
      id: objectId,
      winner: f['winner'] as String,
      loser: f['loser'] as String,
      repTransferred: int.parse(f['rep_transferred'].toString()),
      gameType: ChallengeType
          .values[typeIndex.clamp(0, ChallengeType.values.length - 1)],
      timestamp: DateTime.fromMillisecondsSinceEpoch(epochSec * 1000),
    );
  }

  Future<String> createPlayerProfile(String walletAddress) async {
    _logger.i('Creating on-chain profile for $walletAddress');
    // TODO: implement with zkLogin
    throw UnimplementedError(
      'Transaction signing not yet implemented — zkLogin required',
    );
  }

  Future<String> submitMatchResult({
    required String winnerAddress,
    required String loserAddress,
    required int stake,
    required String gameType,
  }) async {
    _logger.i('Submitting match result stake=$stake game=$gameType');
    // TODO: implement with zkLogin
    throw UnimplementedError(
      'Transaction signing not yet implemented — zkLogin required',
    );
  }

  Future<Map<String, dynamic>> _rpcCall(
    String method,
    List<dynamic> params,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '',
      data: {'jsonrpc': '2.0', 'id': 1, 'method': method, 'params': params},
    );
    final body = response.data!;
    if (body.containsKey('error')) {
      throw SuiException(body['error']['message'] as String);
    }
    return body['result'] as Map<String, dynamic>;
  }

  Map<String, dynamic> _extractFields(Map<String, dynamic> result) {
    final data = result['data'] as Map<String, dynamic>;
    final content = data['content'] as Map<String, dynamic>;
    return content['fields'] as Map<String, dynamic>;
  }
}
