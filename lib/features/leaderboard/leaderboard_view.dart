import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/leaderboard_entry.dart';
import '../../widgets/common/verra_button.dart';
import '../../widgets/common/verra_loader.dart';
import '../../widgets/leaderboard/leaderboard_tile.dart';
import 'leaderboard_viewmodel.dart';

class LeaderboardView extends StackedView<LeaderboardViewModel> {
  const LeaderboardView({super.key});

  @override
  Widget builder(
    BuildContext context,
    LeaderboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          AppStrings.leaderboard,
          style: AppTextStyles.headlineMedium,
        ),
      ),
      body: SafeArea(top: false, child: _buildBody(viewModel)),
    );
  }

  Widget _buildBody(LeaderboardViewModel viewModel) {
    if (viewModel.isBusy && viewModel.entries.isEmpty) {
      return const VerraLoader(message: 'Loading rankings...');
    }
    if (viewModel.hasError) {
      return _ErrorState(
        message:
            viewModel.modelError?.toString() ?? AppStrings.somethingWentWrong,
        onRetry: viewModel.refresh,
      );
    }
    if (viewModel.isEmpty) {
      return const Center(
        child: Text(
          'No players yet. Be the first.',
          style: AppTextStyles.bodyMedium,
        ),
      );
    }
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      onRefresh: viewModel.refresh,
      child: _LeaderboardList(
        entries: viewModel.entries,
        currentPlayerEntry: viewModel.currentPlayerEntry,
      ),
    );
  }

  @override
  LeaderboardViewModel viewModelBuilder(BuildContext context) =>
      LeaderboardViewModel();

  @override
  void onViewModelReady(LeaderboardViewModel viewModel) => viewModel.init();
}

class _LeaderboardList extends StatelessWidget {
  const _LeaderboardList({
    required this.entries,
    required this.currentPlayerEntry,
  });

  final List<LeaderboardEntry> entries;
  final LeaderboardEntry? currentPlayerEntry;

  @override
  Widget build(BuildContext context) {
    final hasCurrent = currentPlayerEntry != null;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: entries.length + (hasCurrent ? 2 : 0),
      itemBuilder: (context, index) {
        if (hasCurrent) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: LeaderboardTile(
                entry: currentPlayerEntry!,
                isCurrentPlayer: true,
              ),
            );
          }
          if (index == 1) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('Top Players', style: AppTextStyles.titleLarge),
            );
          }
          return LeaderboardTile(entry: entries[index - 2]);
        }
        return LeaderboardTile(entry: entries[index]);
      },
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
