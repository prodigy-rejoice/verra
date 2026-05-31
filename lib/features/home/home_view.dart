import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/player_profile.dart';
import '../../widgets/common/verra_button.dart';
import '../../widgets/common/verra_card.dart';
import '../../widgets/common/verra_rank_badge.dart';
import '../../widgets/profile/rep_score_widget.dart';
import '../leaderboard/leaderboard_view.dart';
import '../profile/profile_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: _buildActiveTab(viewModel)),
      bottomNavigationBar: _HomeNavBar(
        activeTab: viewModel.activeTab,
        onTap: viewModel.setActiveTab,
      ),
    );
  }

  Widget _buildActiveTab(HomeViewModel viewModel) {
    switch (viewModel.activeTab) {
      case HomeTab.play:
        return _PlayTab(viewModel: viewModel);
      case HomeTab.leaderboard:
        return const LeaderboardView();
      case HomeTab.profile:
        return ProfileView(onPlayPressedOverride: viewModel.switchToPlayTab);
    }
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.init();
}

class _PlayTab extends StatelessWidget {
  const _PlayTab({required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel.isBusy) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (viewModel.hasError) {
      return _ErrorState(
        message:
            viewModel.modelError?.toString() ?? AppStrings.somethingWentWrong,
        onRetry: viewModel.refresh,
      );
    }
    final profile = viewModel.profile;
    if (profile == null) {
      return const Center(child: Text(AppStrings.somethingWentWrong));
    }
    return _PlayContent(
      profile: profile,
      displayName: viewModel.displayName,
      onFindMatch: viewModel.findMatch,
    );
  }
}

class _PlayContent extends StatelessWidget {
  const _PlayContent({
    required this.profile,
    required this.displayName,
    required this.onFindMatch,
  });

  final PlayerProfile profile;
  final String displayName;
  final VoidCallback onFindMatch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, $displayName',
            style: AppTextStyles.titleLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          _RepScoreCard(profile: profile),
          const SizedBox(height: 16),
          _StatChipRow(profile: profile),
          const Spacer(),
          VerraButton(label: AppStrings.findMatch, onTap: onFindMatch),
        ],
      ),
    );
  }
}

class _RepScoreCard extends StatelessWidget {
  const _RepScoreCard({required this.profile});

  final PlayerProfile profile;

  @override
  Widget build(BuildContext context) {
    return VerraCard(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      child: Column(
        children: [
          RepScoreWidget(score: profile.repScore, rank: profile.rank),
          const SizedBox(height: 12),
          VerraRankBadge(rank: profile.rank),
        ],
      ),
    );
  }
}

class _StatChipRow extends StatelessWidget {
  const _StatChipRow({required this.profile});

  final PlayerProfile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatChip(
            label: AppStrings.wins,
            value: '${profile.wins}',
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatChip(
            label: AppStrings.losses,
            value: '${profile.losses}',
            color: AppColors.error,
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return VerraCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTextStyles.headlineMedium.copyWith(color: color),
          ),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _HomeNavBar extends StatelessWidget {
  const _HomeNavBar({required this.activeTab, required this.onTap});

  final HomeTab activeTab;
  final ValueChanged<HomeTab> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.surface,
      currentIndex: activeTab.index,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textHint,
      selectedLabelStyle: AppTextStyles.caption.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppTextStyles.caption,
      onTap: (index) => onTap(HomeTab.values[index]),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_esports_outlined),
          activeIcon: Icon(Icons.sports_esports),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard_outlined),
          activeIcon: Icon(Icons.leaderboard),
          label: AppStrings.leaderboard,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: AppStrings.profile,
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 36),
          const SizedBox(height: 12),
          Text(
            message,
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          VerraButton(label: AppStrings.retry, onTap: onRetry),
        ],
      ),
    );
  }
}
