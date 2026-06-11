import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../widgets/common/verra_button.dart';
import '../../../widgets/common/verra_card.dart';
import '../../../widgets/match/countdown_timer_widget.dart';
import 'crypto_trivia_viewmodel.dart';

class CryptoTriviaView extends StackedView<CryptoTriviaViewModel> {
  const CryptoTriviaView({
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
    CryptoTriviaViewModel viewModel,
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
                  if (viewModel.gameStatus == CryptoTriviaStatus.finished)
                    _GameOverOverlay(viewModel: viewModel),
                ],
              ),
            ),
            if (viewModel.gameStatus == CryptoTriviaStatus.playing)
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
  CryptoTriviaViewModel viewModelBuilder(BuildContext context) =>
      CryptoTriviaViewModel();

  @override
  void onViewModelReady(CryptoTriviaViewModel viewModel) {
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

  final CryptoTriviaViewModel viewModel;

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
          const SizedBox(height: 20),
          VerraCard(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Text(
              viewModel.currentQuestion,
              style: AppTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(child: _AnswerList(viewModel: viewModel)),
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

class _AnswerList extends StatelessWidget {
  const _AnswerList({required this.viewModel});

  final CryptoTriviaViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final opts = viewModel.options;
    return ListView.separated(
      itemCount: opts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _AnswerCard(
        answer: opts[i],
        feedback: _feedbackFor(opts[i]),
        onTap: () => viewModel.onAnswerSelected(opts[i]),
      ),
    );
  }

  _AnswerFeedback _feedbackFor(String answer) {
    if (!viewModel.hasAnswered) return _AnswerFeedback.none;
    final isCorrectChoice = answer == viewModel.correctAnswer;
    final isSelectedChoice = answer == viewModel.selectedAnswer;
    if (isCorrectChoice) return _AnswerFeedback.correct;
    if (isSelectedChoice) return _AnswerFeedback.wrong;
    return _AnswerFeedback.none;
  }
}

enum _AnswerFeedback { none, correct, wrong }

class _AnswerCard extends StatelessWidget {
  const _AnswerCard({
    required this.answer,
    required this.feedback,
    required this.onTap,
  });

  final String answer;
  final _AnswerFeedback feedback;
  final VoidCallback onTap;

  Color get _background {
    switch (feedback) {
      case _AnswerFeedback.correct:
        return AppColors.success;
      case _AnswerFeedback.wrong:
        return AppColors.error;
      case _AnswerFeedback.none:
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
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(answer, style: AppTextStyles.bodyLarge),
        ),
      ),
    );
  }
}

class _GameOverOverlay extends StatelessWidget {
  const _GameOverOverlay({required this.viewModel});

  final CryptoTriviaViewModel viewModel;

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
