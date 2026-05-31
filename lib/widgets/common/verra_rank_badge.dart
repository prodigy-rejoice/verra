import 'package:flutter/material.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/player_rank.dart';

class VerraRankBadge extends StatelessWidget {
  const VerraRankBadge({super.key, required this.rank});

  final PlayerRank rank;

  @override
  Widget build(BuildContext context) {
    final color = rank.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        rank.displayName,
        style: AppTextStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
