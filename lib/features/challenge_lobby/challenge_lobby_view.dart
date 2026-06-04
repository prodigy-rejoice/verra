import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/challenge_type.dart';
import '../../widgets/common/dot_loader.dart';
import '../../widgets/common/verra_button.dart';
import '../../widgets/common/verra_loader.dart';
import 'challenge_lobby_viewmodel.dart';

class ChallengeLobbyView extends StackedView<ChallengeLobbyViewModel> {
  const ChallengeLobbyView({super.key, this.initialChallengeType});

  final ChallengeType? initialChallengeType;

  @override
  Widget builder(
    BuildContext context,
    ChallengeLobbyViewModel viewModel,
    Widget? child,
  ) {
    return PopScope(
      canPop: !viewModel.isSearching,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && viewModel.isSearching) {
          viewModel.cancelSearch();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.textPrimary),
          title: const Text(
            'Find a Match',
            style: AppTextStyles.headlineMedium,
          ),
        ),
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              _buildBody(viewModel),
              if (viewModel.isSearching)
                _SearchingOverlay(onCancel: viewModel.cancelSearch),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ChallengeLobbyViewModel viewModel) {
    if (viewModel.isBusy && viewModel.profile == null) {
      return const VerraLoader();
    }
    return Padding(
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
                    'Choose your challenge',
                    style: AppTextStyles.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _ChallengeGrid(
                    selected: viewModel.selectedChallengeType,
                    onSelect: viewModel.selectChallengeType,
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Set your stake',
                    style: AppTextStyles.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _StakeRow(
                    selected: viewModel.selectedStake,
                    isAffordable: viewModel.isStakeAffordable,
                    onSelect: viewModel.selectStake,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your max stake: ${viewModel.maxStake} rep',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          VerraButton(
            label: AppStrings.findMatch,
            isDisabled: !viewModel.canProceed,
            onTap: viewModel.findMatch,
          ),
        ],
      ),
    );
  }

  @override
  ChallengeLobbyViewModel viewModelBuilder(BuildContext context) =>
      ChallengeLobbyViewModel();

  @override
  void onViewModelReady(ChallengeLobbyViewModel viewModel) =>
      viewModel.init(initialChallengeType: initialChallengeType);
}

class _ChallengeGrid extends StatelessWidget {
  const _ChallengeGrid({required this.selected, required this.onSelect});

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
        return _ChallengeCard(
          type: type,
          isSelected: selected == type,
          onTap: () => onSelect(type),
        );
      }).toList(),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({
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

class _StakeRow extends StatelessWidget {
  const _StakeRow({
    required this.selected,
    required this.isAffordable,
    required this.onSelect,
  });

  final int? selected;
  final bool Function(int stake) isAffordable;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ChallengeLobbyViewModel.stakePresets.map((stake) {
        final isSelected = selected == stake;
        final affordable = isAffordable(stake);
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _StakeChip(
              stake: stake,
              isSelected: isSelected,
              isAffordable: affordable,
              onTap: affordable ? () => onSelect(stake) : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _StakeChip extends StatelessWidget {
  const _StakeChip({
    required this.stake,
    required this.isSelected,
    required this.isAffordable,
    required this.onTap,
  });

  final int stake;
  final bool isSelected;
  final bool isAffordable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isAffordable ? 1.0 : 0.4,
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text('$stake', style: AppTextStyles.labelLarge),
          ),
        ),
      ),
    );
  }
}

class _SearchingOverlay extends StatelessWidget {
  const _SearchingOverlay({required this.onCancel});

  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: ColoredBox(
          color: AppColors.background.withValues(alpha: 0.88),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DotLoader(),
                const SizedBox(height: 20),
                Text(
                  AppStrings.searching,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: VerraButton(
                    label: AppStrings.cancel,
                    onTap: onCancel,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
