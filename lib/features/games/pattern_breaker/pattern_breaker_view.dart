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
    PatternBreakerViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            _GameBody(viewModel: viewModel),
            if (viewModel.gameStatus == PatternBreakerStatus.playing)
              Positioned(
                bottom: 24,
                left: 48,
                right: 48,
                child: VerraButton(
                  label: 'Resign',
                  onTap: viewModel.resign,
                ),
              ),
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
      isPractice: isPractice,
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
            wrongAnswers: viewModel.wrongAnswers,
          ),
          const SizedBox(height: 16),
          CountdownTimerWidget(
            seconds: viewModel.timeRemaining,
            isUrgent: viewModel.timeRemaining <= 10,
          ),
          const SizedBox(height: 24),
          _SequenceRow(sequence: viewModel.displaySequence),
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
  const _ScoreRow({required this.playerScore, required this.wrongAnswers});

  final int playerScore;
  final int wrongAnswers;

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
          '$wrongAnswers',
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
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      alignment: WrapAlignment.center,
      children: [
        for (final item in sequence) _SequenceBox(text: item, highlight: false),
        const _SequenceBox(text: '?', highlight: true),
      ],
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
      width: 48,
      height: 48,
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
        textAlign: TextAlign.center,
        style: AppTextStyles.titleLarge.copyWith(
          color: highlight ? AppColors.primary : AppColors.textPrimary,
          fontSize: 12,
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
    final raw = viewModel.options;
    final display = viewModel.displayOptions;
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        raw.length,
        (i) => _OptionCard(
          option: display[i],
          feedback: _feedbackFor(raw[i]),
          onTap: () => viewModel.onOptionSelected(raw[i]),
        ),
      ),
    );
  }

  _OptionFeedback _feedbackFor(String rawOption) {
    if (!viewModel.hasAnswered) return _OptionFeedback.none;
    final isCorrect = rawOption == viewModel.correctAnswer;
    final isSelected = rawOption == viewModel.selectedAnswer;
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
    final practice = viewModel.isPractice;
    final won = viewModel.isWinner;
    final stake = viewModel.stakeAmount;
    final title = practice ? 'Practice Complete' : (won ? 'Victory!' : 'Defeat');
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
