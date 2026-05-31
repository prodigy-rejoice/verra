import 'package:flutter/material.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/player_rank.dart';

class RepScoreWidget extends StatelessWidget {
  const RepScoreWidget({
    super.key,
    required this.score,
    required this.rank,
  });

  final int score;
  final PlayerRank rank;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$score', style: AppTextStyles.repScore),
        const SizedBox(height: 8),
        Text(
          rank.displayName,
          style: AppTextStyles.labelLarge.copyWith(color: rank.color),
        ),
      ],
    );
  }
}
