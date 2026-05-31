import 'dart:math';

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class DotLoader extends StatefulWidget {
  const DotLoader({
    super.key,
    this.color = AppColors.primary,
    this.dotSize = 12,
    this.spacing = 10,
  });

  final Color color;
  final double dotSize;
  final double spacing;

  @override
  State<DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<DotLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, _buildDot),
        );
      },
    );
  }

  Widget _buildDot(int index) {
    final phase = (_controller.value - index * 0.18) % 1.0;
    final pulse = sin(phase * pi).clamp(0.0, 1.0);
    final scale = 0.55 + 0.45 * pulse;
    final opacity = 0.35 + 0.65 * pulse;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
      child: Opacity(
        opacity: opacity,
        child: Transform.scale(
          scale: scale,
          child: Container(
            width: widget.dotSize,
            height: widget.dotSize,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
