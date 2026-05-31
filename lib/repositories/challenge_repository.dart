import 'package:logger/logger.dart';
import '../app/app.locator.dart';
import '../app/app.logger.dart';
import '../core/enums/challenge_type.dart';
import '../core/exceptions/verra_exception.dart';
import '../models/challenge.dart';
import '../services/supabase_service.dart';

class ChallengeRepository {
  final SupabaseService _supabaseService = locator<SupabaseService>();
  final Logger _logger = getLogger('ChallengeRepository');

  Future<List<Challenge>> getChallenges(ChallengeType type) async {
    _logger.i('Fetching challenges for ${type.key}');
    try {
      return await _supabaseService.fetchChallenges(type);
    } on VerraException {
      rethrow;
    } catch (e, stack) {
      _logger.e('Failed to fetch challenges', error: e, stackTrace: stack);
      throw VerraException('Unable to load challenges.', cause: e);
    }
  }
}
