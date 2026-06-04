import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../widgets/common/verra_button.dart';
import 'word_stake_viewmodel.dart';

class WordStakeView extends StackedView<WordStakeViewModel> {
  const WordStakeView({
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
    WordStakeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            _GameBody(viewModel: viewModel),
            if (viewModel.gameStatus == WordStakeStatus.finished)
              _GameOverOverlay(viewModel: viewModel),
          ],
        ),
      ),
    );
  }

  @override
  WordStakeViewModel viewModelBuilder(BuildContext context) =>
      WordStakeViewModel();

  @override
  void onViewModelReady(WordStakeViewModel viewModel) {
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

  final WordStakeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        children: [
          _OpponentStatus(
            attempts: viewModel.opponentAttempts,
            max: viewModel.maxAttempts,
          ),
          const SizedBox(height: 16),
          _LetterGrid(viewModel: viewModel),
          const SizedBox(height: 14),
          _KnownLettersSection(template: viewModel.revealedTemplate),
          const SizedBox(height: 10),
          _HintButton(
            hintUsed: viewModel.hintUsed,
            onTap: viewModel.useHint,
          ),
          const Spacer(),
          _Keyboard(viewModel: viewModel),
        ],
      ),
    );
  }
}

class _OpponentStatus extends StatelessWidget {
  const _OpponentStatus({required this.attempts, required this.max});

  final int attempts;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Opponent: $attempts/$max',
        style: AppTextStyles.bodySmall,
      ),
    );
  }
}

class _LetterGrid extends StatelessWidget {
  const _LetterGrid({required this.viewModel});

  final WordStakeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        viewModel.maxAttempts,
        (row) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              viewModel.wordLength,
              (col) => _LetterCell(
                letter: viewModel.letterAtCell(row, col),
                status: viewModel.statusForCell(row, col),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LetterCell extends StatelessWidget {
  const _LetterCell({required this.letter, required this.status});

  final String letter;
  final LetterStatus? status;

  Color get _background {
    switch (status) {
      case LetterStatus.correct:
        return AppColors.success;
      case LetterStatus.present:
        return AppColors.warning;
      case LetterStatus.absent:
        return AppColors.surfaceElevated;
      case null:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _background,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(letter, style: AppTextStyles.headlineMedium),
    );
  }
}

class _KnownLettersSection extends StatelessWidget {
  const _KnownLettersSection({required this.template});

  final List<String> template;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Known letters',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(template.length, (i) {
            final letter = template[i];
            return _TemplateBox(letter: letter);
          }),
        ),
      ],
    );
  }
}

class _TemplateBox extends StatelessWidget {
  const _TemplateBox({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    final isRevealed = letter.isNotEmpty;
    return Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isRevealed ? letter : '–',
        style: AppTextStyles.labelLarge.copyWith(
          color: isRevealed ? AppColors.primary : AppColors.textHint,
          fontWeight: isRevealed ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    );
  }
}

class _HintButton extends StatelessWidget {
  const _HintButton({required this.hintUsed, required this.onTap});

  final bool hintUsed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = hintUsed ? 'Hint Used' : 'Use Hint (1 remaining)';
    final color = hintUsed ? AppColors.textHint : AppColors.primary;
    return Opacity(
      opacity: hintUsed ? 0.6 : 1.0,
      child: OutlinedButton(
        onPressed: hintUsed ? null : onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color),
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _Keyboard extends StatelessWidget {
  const _Keyboard({required this.viewModel});

  final WordStakeViewModel viewModel;

  static const List<String> _row1 = [
    'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P',
  ];
  static const List<String> _row2 = [
    'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L',
  ];
  static const List<String> _row3 = ['Z', 'X', 'C', 'V', 'B', 'N', 'M'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _KeyRow(letters: _row1, viewModel: viewModel),
        _KeyRow(letters: _row2, viewModel: viewModel),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              _ActionKey(
                label: 'ENTER',
                onTap: viewModel.onSubmit,
                flex: 3,
                background: AppColors.primary,
              ),
              ..._row3.map(
                (l) => _LetterKey(letter: l, viewModel: viewModel, flex: 2),
              ),
              _ActionKey(
                icon: Icons.backspace_outlined,
                onTap: viewModel.onDelete,
                flex: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _KeyRow extends StatelessWidget {
  const _KeyRow({required this.letters, required this.viewModel});

  final List<String> letters;
  final WordStakeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: letters
            .map((l) => _LetterKey(letter: l, viewModel: viewModel, flex: 1))
            .toList(),
      ),
    );
  }
}

class _LetterKey extends StatelessWidget {
  const _LetterKey({
    required this.letter,
    required this.viewModel,
    required this.flex,
  });

  final String letter;
  final WordStakeViewModel viewModel;
  final int flex;

  Color _backgroundFor(LetterStatus? status) {
    switch (status) {
      case LetterStatus.correct:
        return AppColors.success;
      case LetterStatus.present:
        return AppColors.warning;
      case LetterStatus.absent:
        return AppColors.border;
      case null:
        return AppColors.surfaceElevated;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = viewModel.letterStatuses[letter];
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: _backgroundFor(status),
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: () => viewModel.onLetterTap(letter),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(letter, style: AppTextStyles.labelLarge),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionKey extends StatelessWidget {
  const _ActionKey({
    this.label,
    this.icon,
    required this.onTap,
    required this.flex,
    this.background,
  });

  final String? label;
  final IconData? icon;
  final VoidCallback onTap;
  final int flex;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: background ?? AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: icon != null
                  ? Icon(icon, color: AppColors.textPrimary, size: 18)
                  : Text(
                      label ?? '',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GameOverOverlay extends StatelessWidget {
  const _GameOverOverlay({required this.viewModel});

  final WordStakeViewModel viewModel;

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
            const SizedBox(height: 8),
            Text(
              'The word was ${viewModel.targetWord}',
              style: AppTextStyles.bodyMedium,
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
