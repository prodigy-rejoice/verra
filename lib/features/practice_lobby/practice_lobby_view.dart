import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/challenge_type.dart';
import '../../widgets/common/verra_button.dart';
import '../../widgets/common/verra_card.dart';
import 'practice_lobby_viewmodel.dart';

class PracticeLobbyView extends StackedView<PracticeLobbyViewModel> {
  const PracticeLobbyView({super.key});

  @override
  Widget builder(
    BuildContext context,
    PracticeLobbyViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Practice', style: AppTextStyles.headlineMedium),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose a game',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _GameGrid(
                        selected: viewModel.selectedChallengeType,
                        onSelect: viewModel.selectChallengeType,
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Practice Mode',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textHint,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const VerraCard(
                        child: Text(
                          'Practice games don\'t affect your rep score. Use this to learn the games before staking.',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              VerraButton(
                label: 'Start Practice',
                isDisabled: !viewModel.canStart,
                onTap: viewModel.startPractice,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PracticeLobbyViewModel viewModelBuilder(BuildContext context) =>
      PracticeLobbyViewModel();
}

class _GameGrid extends StatelessWidget {
  const _GameGrid({required this.selected, required this.onSelect});

  final ChallengeType? selected;
  final ValueChanged<ChallengeType> onSelect;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.05,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: ChallengeType.values.map((type) {
        return _GameCard(
          type: type,
          isSelected: selected == type,
          onTap: () => onSelect(type),
        );
      }).toList(),
    );
  }
}

class _GameCard extends StatelessWidget {
  const _GameCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  final ChallengeType type;
  final bool isSelected;
  final VoidCallback onTap;

  IconData get _icon {
    switch (type) {
      case ChallengeType.chainReflex:
        return Icons.bolt;
      case ChallengeType.cryptoTrivia:
        return Icons.psychology_outlined;
      case ChallengeType.wordStake:
        return Icons.text_fields;
      case ChallengeType.patternBreaker:
        return Icons.grid_view_outlined;
      case ChallengeType.mathDuel:
        return Icons.calculate_outlined;
    }
  }

  String get _description {
    switch (type) {
      case ChallengeType.chainReflex:
        return 'Tap faster than your opponent';
      case ChallengeType.cryptoTrivia:
        return 'Who knows Web3 better';
      case ChallengeType.wordStake:
        return 'Guess the word first';
      case ChallengeType.patternBreaker:
        return 'Spot the pattern, beat the clock';
      case ChallengeType.mathDuel:
        return 'Mental arithmetic at speed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(_icon, color: AppColors.primary, size: 28),
              const Spacer(),
              Text(type.displayName, style: AppTextStyles.titleLarge),
              const SizedBox(height: 6),
              Text(_description, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}