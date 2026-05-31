import 'dart:math';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/app.locator.dart';
import '../app/app.logger.dart';
import '../core/exceptions/verra_exception.dart';
import '../core/utils/nickname_generator.dart';
import '../models/leaderboard_entry.dart';
import '../services/supabase_service.dart';

class LeaderboardRepository {
  // ignore: unused_field
  final SupabaseService _supabaseService = locator<SupabaseService>();
  final Logger _logger = getLogger('LeaderboardRepository');

  static const String _testWalletAddress = '0xVERRA_TEST_WALLET';
  static const String _walletAddressKey = 'verra_wallet_address';
  static const String _displayNameKey = 'verra_display_name';

  Future<List<LeaderboardEntry>> getTopPlayers({int limit = 100}) async {
    _logger.i('Fetching top $limit players');
    // TEST STUB — replace with `_supabaseService.fetchLeaderboard(limit:)`.
    try {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      final localName = await _readLocalDisplayName();
      return _generateFakeEntries(limit, localName);
    } on VerraException {
      rethrow;
    } catch (e, stack) {
      _logger.e('Failed to fetch leaderboard', error: e, stackTrace: stack);
      throw VerraException('Unable to load leaderboard.', cause: e);
    }
  }

  Future<String?> _readLocalDisplayName() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_walletAddressKey) != _testWalletAddress) return null;
    return prefs.getString(_displayNameKey);
  }

  List<LeaderboardEntry> _generateFakeEntries(int limit, String? localName) {
    const total = 20;
    final random = Random();
    final testWalletPosition = random.nextInt(total);
    final scores = _descendingScores(total);
    final entries = <LeaderboardEntry>[];
    for (var i = 0; i < total; i++) {
      final isTestWallet = i == testWalletPosition;
      final address = isTestWallet
          ? _testWalletAddress
          : _fakeAddress(i, random);
      final displayName = isTestWallet
          ? (localName ?? NicknameGenerator.fromAddress(address))
          : NicknameGenerator.fromAddress(address);
      entries.add(
        LeaderboardEntry(
          rankPosition: i + 1,
          walletAddress: address,
          repScore: scores[i],
          wins: 30 - i + random.nextInt(5),
          losses: 5 + i + random.nextInt(4),
          displayName: displayName,
        ),
      );
    }
    return entries.take(limit).toList();
  }

  List<int> _descendingScores(int total) {
    const high = 2400;
    const low = 500;
    final step = (high - low) / (total - 1);
    return List<int>.generate(total, (i) => (high - step * i).round());
  }

  String _fakeAddress(int index, Random random) {
    const hex = '0123456789abcdef';
    final buffer = StringBuffer('0x');
    for (var i = 0; i < 8; i++) {
      buffer.write(hex[random.nextInt(hex.length)]);
    }
    buffer.write(index.toString().padLeft(2, '0'));
    return buffer.toString();
  }
}
