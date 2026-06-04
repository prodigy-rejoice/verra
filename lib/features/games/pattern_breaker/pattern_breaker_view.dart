import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../widgets/common/verra_button.dart';
import '../../../widgets/match/countdown_timer_widget.dart';
import 'pattern_breaker_viewmodel.dart';

class PatternBreakerView extends StackedView<PatternBreakerViewModel> {
  const PatternBreakerView({
    super.key,
    required this.matchId,
    required this.playerAddress,
    required this.opponentAddress,
    required this.stakeAmount,
  });

  final String matchId;
  final String playerAddress;
  final String opponentAddress;
  final int stakeAmount;

  @override
  Widget builder(
    BuildContext context,
    PatternBreakerViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            _GameBody(viewModel: viewModel),
            if (viewModel.gameStatus == PatternBreakerStatus.finished)
              _GameOverOverlay(viewModel: viewModel),
          ],
        ),
      ),
    );
  }

  @override
  PatternBreakerViewModel viewModelBuilder(BuildContext context) =>
      PatternBreakerViewModel();

  @override
  void onViewModelReady(PatternBreakerViewModel viewModel) {
    viewModel.initGame(
      matchId: matchId,
      playerAddress: playerAddress,
      opponentAddress: opponentAddress,
      stakeAmount: stakeAmount,
    );
  }
}

class _GameBody extends StatelessWidget {
  const _GameBody({required this.viewModel});

  final PatternBreakerViewModel viewModel;

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
          const SizedBox(height: 24),
          _SequenceRow(sequence: viewModel.sequence),
          const SizedBox(height: 20),
          Text(
            'What comes next?',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Expanded(child: _OptionsGrid(viewModel: viewModel)),
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

class _SequenceRow extends StatelessWidget {
  const _SequenceRow({required this.sequence});

  final List<String> sequence;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sequence.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final isUnknown = i == sequence.length;
          return _SequenceBox(
            text: isUnknown ? '?' : sequence[i],
            highlight: isUnknown,
          );
        },
      ),
    );
  }
}

class _SequenceBox extends StatelessWidget {
  const _SequenceBox({required this.text, required this.highlight});

  final String text;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
          color: highlight ? AppColors.primary : AppColors.border,
          width: highlight ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: AppTextStyles.titleLarge.copyWith(
          color: highlight ? AppColors.primary : AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _OptionsGrid extends StatelessWidget {
  const _OptionsGrid({required this.viewModel});

  final PatternBreakerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final opts = viewModel.options;
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      children: opts
          .map(
            (o) => _OptionCard(
              option: o,
              feedback: _feedbackFor(o),
              onTap: () => viewModel.onOptionSelected(o),
            ),
          )
          .toList(),
    );
  }

  _OptionFeedback _feedbackFor(String option) {
    if (!viewModel.hasAnswered) return _OptionFeedback.none;
    final isCorrect = option == viewModel.correctAnswer;
    final isSelected = option == viewModel.selectedAnswer;
    if (isCorrect) return _OptionFeedback.correct;
    if (isSelected) return _OptionFeedback.wrong;
    return _OptionFeedback.none;
  }
}

enum _OptionFeedback { none, correct, wrong }

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.option,
    required this.feedback,
    required this.onTap,
  });

  final String option;
  final _OptionFeedback feedback;
  final VoidCallback onTap;

  Color get _background {
    switch (feedback) {
      case _OptionFeedback.correct:
        return AppColors.success;
      case _OptionFeedback.wrong:
        return AppColors.error;
      case _OptionFeedback.none:
        return AppColors.surface;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(option, style: AppTextStyles.headlineMedium),
        ),
      ),
    );
  }
}

class _GameOverOverlay extends StatelessWidget {
  const _GameOverOverlay({required this.viewModel});

  final PatternBreakerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final won = viewModel.isWinner;
    final stake = viewModel.stakeAmount;
    return Positioned.fill(
      child: ColoredBox(
        color: AppColors.background.withValues(alpha: 0.92),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              won ? 'Victory!' : 'Defeat',
              style: AppTextStyles.headlineLarge.copyWith(
                color: won ? AppColors.success : AppColors.error,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              won ? '+$stake REP' : '-$stake REP',
              style: AppTextStyles.bodyLarge,
            ),
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
