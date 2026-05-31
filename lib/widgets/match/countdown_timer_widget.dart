import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class CountdownTimerWidget extends StatelessWidget {
  const CountdownTimerWidget({
    super.key,
    required this.seconds,
    this.isUrgent = false,
  });

  final int seconds;
  final bool isUrgent;

  String get _formatted {
    final s = seconds.clamp(0, 59);
    return '0:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final color = isUrgent ? AppColors.error : AppColors.textPrimary;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: Text(
        _formatted,
        key: ValueKey(seconds),
        style: AppTextStyles.headlineLarge.copyWith(color: color),
      ),
    );
  }
}
