import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/app.locator.dart';
import '../app/app.logger.dart';
import '../core/exceptions/verra_exception.dart';
import '../core/utils/nickname_generator.dart';
import '../models/player_profile.dart';
import '../services/sui_service.dart';

class PlayerRepository {
  final SuiService _suiService = locator<SuiService>();
  final Logger _logger = getLogger('PlayerRepository');

  static const String _walletAddressKey = 'verra_wallet_address';
  static const String _displayNameKey = 'verra_display_name';

  Future<PlayerProfile> getProfile(String walletAddress) async {
    _logger.i('Fetching profile for $walletAddress');
    try {
      final profile = await _suiService.getPlayerProfile(walletAddress);
      final displayName = await _readLocalDisplayName(walletAddress);
      _logger.d('Profile fetched — rank: ${profile.rank.displayName}');
      return displayName == null
          ? profile
          : profile.copyWith(displayName: displayName);
    } on VerraException {
      rethrow;
    } catch (e, stack) {
      _logger.e('Failed to fetch profile', error: e, stackTrace: stack);
      throw VerraException('Unable to load player profile.', cause: e);
    }
  }

  Future<String?> _readLocalDisplayName(String walletAddress) async {
    final prefs = await SharedPreferences.getInstance();
    final savedWallet = prefs.getString(_walletAddressKey);
    if (savedWallet != walletAddress) return null;
    final existing = prefs.getString(_displayNameKey);
    if (existing != null && existing.isNotEmpty) return existing;
    final generated = NicknameGenerator.fromAddress(walletAddress);
    await prefs.setString(_displayNameKey, generated);
    _logger.d('Backfilled nickname $generated for $walletAddress');
    return generated;
  }

  Future<String> createProfile(String walletAddress) async {
    _logger.i('Creating profile for $walletAddress');
    try {
      final txDigest = await _suiService.createPlayerProfile(walletAddress);
      _logger.d('Profile created — digest: $txDigest');
      return txDigest;
    } on VerraException {
      rethrow;
    } catch (e, stack) {
      _logger.e('Failed to create profile', error: e, stackTrace: stack);
      throw VerraException('Unable to create player profile.', cause: e);
    }
  }
}
