import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../widgets/common/verra_button.dart';
import '../../../widgets/match/countdown_timer_widget.dart';
import 'math_duel_viewmodel.dart';

class MathDuelView extends StackedView<MathDuelViewModel> {
  const MathDuelView({
    super.key,
    required this.matchId,
    required this.playerAddress,
    required this.opponentAddress,
    required this.stakeAmount,
    this.isPractice = false,
  });

  final String matchId;
  final String playerAddress;
  final String opponentAddress;
  final int stakeAmount;
  final bool isPractice;

  @override
  Widget builder(
    BuildContext context,
    MathDuelViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  _GameBody(viewModel: viewModel),
                  if (viewModel.gameStatus == MathDuelStatus.finished)
                    _GameOverOverlay(viewModel: viewModel),
                ],
              ),
            ),
            if (viewModel.gameStatus == MathDuelStatus.playing)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: viewModel.resign,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Resign',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  MathDuelViewModel viewModelBuilder(BuildContext context) =>
      MathDuelViewModel();

  @override
  void onViewModelReady(MathDuelViewModel viewModel) {
    viewModel.initGame(
      matchId: matchId,
      playerAddress: playerAddress,
      opponentAddress: opponentAddress,
      stakeAmount: stakeAmount,
      isPractice: isPractice,
    );
  }
}

class _GameBody extends StatelessWidget {
  const _GameBody({required this.viewModel});

  final MathDuelViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        children: [
          _ScoreRow(
            playerScore: viewModel.playerScore,
            opponentScore: viewModel.opponentScore,
          ),
          const SizedBox(height: 16),
          CountdownTimerWidget(
            seconds: viewModel.timeRemaining,
            isUrgent: viewModel.timeRemaining <= 10,
          ),
          const SizedBox(height: 28),
          Text(
            viewModel.currentProblem,
            style: AppTextStyles.displayLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _InputDisplay(
            value: viewModel.playerInput,
            feedback: viewModel.lastSubmitCorrect,
          ),
          const Spacer(),
          _NumberPad(viewModel: viewModel),
        ],
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({required this.playerScore, required this.opponentScore});

  final int playerScore;
  final int opponentScore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$playerScore',
          style: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.success,
          ),
        ),
        const Spacer(),
        Text('VS', style: AppTextStyles.bodyLarge),
        const Spacer(),
        Text(
          '$opponentScore',
          style: AppTextStyles.headlineLarge.copyWith(color: AppColors.error),
        ),
      ],
    );
  }
}

class _InputDisplay extends StatelessWidget {
  const _InputDisplay({required this.value, required this.feedback});

  final String value;
  final bool? feedback;

  Color get _background {
    if (feedback == true) return AppColors.success.withValues(alpha: 0.3);
    if (feedback == false) return AppColors.error.withValues(alpha: 0.3);
    return AppColors.surface;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        value.isEmpty ? '_' : value,
        style: AppTextStyles.displayLarge,
      ),
    );
  }
}

class _NumberPad extends StatelessWidget {
  const _NumberPad({required this.viewModel});

  final MathDuelViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PadRow(children: [
          _PadKey(label: '1', onTap: () => viewModel.onNumberTap('1')),
          _PadKey(label: '2', onTap: () => viewModel.onNumberTap('2')),
          _PadKey(label: '3', onTap: () => viewModel.onNumberTap('3')),
        ]),
        _PadRow(children: [
          _PadKey(label: '4', onTap: () => viewModel.onNumberTap('4')),
          _PadKey(label: '5', onTap: () => viewModel.onNumberTap('5')),
          _PadKey(label: '6', onTap: () => viewModel.onNumberTap('6')),
        ]),
        _PadRow(children: [
          _PadKey(label: '7', onTap: () => viewModel.onNumberTap('7')),
          _PadKey(label: '8', onTap: () => viewModel.onNumberTap('8')),
          _PadKey(label: '9', onTap: () => viewModel.onNumberTap('9')),
        ]),
        _PadRow(children: [
          _PadKey(label: '0', onTap: () => viewModel.onNumberTap('0')),
          _PadKey(icon: Icons.backspace_outlined, onTap: viewModel.onDelete),
          _PadKey(
            label: '=',
            onTap: viewModel.onSubmit,
            background: AppColors.primary,
          ),
        ]),
      ],
    );
  }
}

class _PadRow extends StatelessWidget {
  const _PadRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: children
            .map((c) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: c,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _PadKey extends StatelessWidget {
  const _PadKey({
    this.label,
    this.icon,
    required this.onTap,
    this.background,
  });

  final String? label;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background ?? AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 60,
          alignment: Alignment.center,
          child: icon != null
              ? Icon(icon, color: AppColors.textPrimary)
              : Text(label ?? '', style: AppTextStyles.headlineMedium),
        ),
      ),
    );
  }
}

class _GameOverOverlay extends StatelessWidget {
  const _GameOverOverlay({required this.viewModel});

  final MathDuelViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final practice = viewModel.isPractice;
    final won = viewModel.isWinner;
    final stake = viewModel.stakeAmount;
    final title = practice
        ? 'Practice Complete'
        : (won ? 'Victory!' : 'Defeat');
    final titleColor = practice
        ? AppColors.primary
        : (won ? AppColors.success : AppColors.error);
    final subtitle = practice
        ? 'Score: ${viewModel.playerScore}'
        : (won ? '+$stake REP' : '-$stake REP');
    return Positioned.fill(
      child: ColoredBox(
        color: AppColors.background.withValues(alpha: 0.92),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTextStyles.headlineLarge.copyWith(color: titleColor),
            ),
            const SizedBox(height: 12),
            Text(subtitle, style: AppTextStyles.bodyLarge),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: VerraButton(
                label: 'Back to Home',
                onTap: viewModel.navigateToHome,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
