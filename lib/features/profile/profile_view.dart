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
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({super.key, this.onPlayPressedOverride});

  final VoidCallback? onPlayPressedOverride;

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _buildBody(viewModel),
      ),
    );
  }

  Widget _buildBody(ProfileViewModel viewModel) {
    if (viewModel.isBusy) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (viewModel.hasError) {
      return _ErrorState(
        message: viewModel.modelError?.toString() ?? AppStrings.somethingWentWrong,
        onRetry: viewModel.refresh,
      );
    }
    final profile = viewModel.profile;
    if (profile == null) {
      return const Center(child: Text(AppStrings.somethingWentWrong));
    }
    return _LoadedBody(profile: profile, onPlayPressed: viewModel.onPlayPressed);
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();

  @override
  void onViewModelReady(ProfileViewModel viewModel) =>
      viewModel.init(onPlayPressedOverride: onPlayPressedOverride);
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.profile, required this.onPlayPressed});

  final PlayerProfile profile;
  final VoidCallback onPlayPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          if (profile.displayName != null) ...[
            Text(profile.displayName!, style: AppTextStyles.headlineMedium),
            const SizedBox(height: 16),
          ],
          RepScoreWidget(score: profile.repScore, rank: profile.rank),
          const SizedBox(height: 12),
          VerraRankBadge(rank: profile.rank),
          const SizedBox(height: 28),
          _StatsRow(profile: profile),
          const SizedBox(height: 16),
          _WinRateLine(profile: profile),
          const SizedBox(height: 28),
          const _MatchHistorySection(),
          const Spacer(),
          VerraButton(
            label: 'Play Now',
            onTap: onPlayPressed,
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.profile});

  final PlayerProfile profile;

  @override
  Widget build(BuildContext context) {
    return VerraCard(
      child: Row(
        children: [
          _StatColumn(label: AppStrings.wins, value: '${profile.wins}'),
          const _StatDivider(),
          _StatColumn(label: AppStrings.losses, value: '${profile.losses}'),
          const _StatDivider(),
          _StatColumn(
            label: 'Challenges',
            value: '${profile.challengesCompleted}',
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: AppTextStyles.headlineMedium),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      color: AppColors.border,
    );
  }
}

class _WinRateLine extends StatelessWidget {
  const _WinRateLine({required this.profile});

  final PlayerProfile profile;

  @override
  Widget build(BuildContext context) {
    final pct = (profile.winRate * 100).toStringAsFixed(1);
    return Text(
      '${AppStrings.winRate}: $pct%',
      style: AppTextStyles.bodyMedium,
    );
  }
}

class _MatchHistorySection extends StatelessWidget {
  const _MatchHistorySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Match History', style: AppTextStyles.titleLarge),
        ),
        const SizedBox(height: 16),
        VerraCard(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
          child: Column(
            children: const [
              Icon(
                Icons.sports_esports_outlined,
                size: 36,
                color: AppColors.textHint,
              ),
              SizedBox(height: 12),
              Text(
                'No matches yet. Play your first game.',
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
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
          Text(message, style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          VerraButton(label: AppStrings.retry, onTap: onRetry),
        ],
      ),
    );
  }
}
