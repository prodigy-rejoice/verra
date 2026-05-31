import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/extensions/string_extensions.dart';
import '../../models/leaderboard_entry.dart';
import '../common/verra_rank_badge.dart';

class LeaderboardTile extends StatelessWidget {
  const LeaderboardTile({
    super.key,
    required this.entry,
    this.isCurrentPlayer = false,
  });

  final LeaderboardEntry entry;
  final bool isCurrentPlayer;

  Color get _rankColor {
    switch (entry.rankPosition) {
      case 1:
        return AppColors.rankGold;
      case 2:
        return AppColors.rankSilver;
      case 3:
        return AppColors.rankBronze;
      default:
        return AppColors.textHint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isCurrentPlayer ? AppColors.surfaceElevated : Colors.transparent,
        border: isCurrentPlayer
            ? Border.all(color: AppColors.primary, width: 1)
            : const Border(
                bottom: BorderSide(color: AppColors.border, width: 1),
              ),
        borderRadius: isCurrentPlayer ? BorderRadius.circular(12) : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '${entry.rankPosition}',
              style: AppTextStyles.labelLarge.copyWith(color: _rankColor),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              entry.displayName ?? entry.walletAddress.shortAddress,
              style: AppTextStyles.bodyLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${entry.repScore}',
            style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          VerraRankBadge(rank: entry.tier),
        ],
      ),
    );
  }
}
