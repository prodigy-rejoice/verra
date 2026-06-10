import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../core/enums/challenge_type.dart';

class PracticeLobbyViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('PracticeLobbyViewModel');

  static const String _walletAddressKey = 'verra_wallet_address';

  ChallengeType? _selectedChallengeType;
  ChallengeType? get selectedChallengeType => _selectedChallengeType;

  bool get canStart => _selectedChallengeType != null;

  void selectChallengeType(ChallengeType type) {
    _selectedChallengeType = type;
    notifyListeners();
  }

  Future<void> startPractice() async {
    if (!canStart) return;
    _logger.i('Starting practice — ${_selectedChallengeType!.key}');
    final prefs = await SharedPreferences.getInstance();
    final playerAddress = prefs.getString(_walletAddressKey) ?? '';
    await _routeToPracticeGame(playerAddress);
  }

  Future<void> _routeToPracticeGame(String playerAddress) async {
    switch (_selectedChallengeType!) {
      case ChallengeType.chainReflex:
        await _navigationService.navigateToChainReflexView(
          matchId: 'practice',
          playerAddress: playerAddress,
          opponentAddress: '',
          stakeAmount: 0,
          isPractice: true,
        );
        break;
      case ChallengeType.cryptoTrivia:
        await _navigationService.navigateToCryptoTriviaView(
          matchId: 'practice',
          playerAddress: playerAddress,
          opponentAddress: '',
          stakeAmount: 0,
          isPractice: true,
        );
        break;
      case ChallengeType.mathDuel:
        await _navigationService.navigateToMathDuelView(
          matchId: 'practice',
          playerAddress: playerAddress,
          opponentAddress: '',
          stakeAmount: 0,
          isPractice: true,
        );
        break;
      case ChallengeType.wordStake:
        await _navigationService.navigateToWordStakeView(
          matchId: 'practice',
          playerAddress: playerAddress,
          opponentAddress: '',
          stakeAmount: 0,
          isPractice: true,
        );
        break;
      case ChallengeType.patternBreaker:
        await _navigationService.navigateToPatternBreakerView(
          matchId: 'practice',
          playerAddress: playerAddress,
          opponentAddress: '',
          stakeAmount: 0,
          isPractice: true,
        );
        break;
    }
  }
}