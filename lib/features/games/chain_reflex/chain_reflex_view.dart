import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../widgets/common/verra_button.dart';
import '../../../widgets/match/countdown_timer_widget.dart';
import 'chain_reflex_viewmodel.dart';

class ChainReflexView extends StackedView<ChainReflexViewModel> {
  const ChainReflexView({
    super.key,
    required this.matchId,
    required this.playerAddress,
    required this.opponentAddress,
    required this.stakeAmount,
  });

  final String matchId;
  final String playerAddress;
  final String opponentAddress;
  final int stakeAmount;

  @override
  Widget builder(
    BuildContext context,
    ChainReflexViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            _GameBody(viewModel: viewModel),
            if (viewModel.gameStatus == ChainReflexStatus.finished)
              _GameOverOverlay(viewModel: viewModel),
          ],
        ),
      ),
    );
  }

  @override
  ChainReflexViewModel viewModelBuilder(BuildContext context) =>
      ChainReflexViewModel();

  @override
  void onViewModelReady(ChainReflexViewModel viewModel) {
    viewModel.initGame(
      matchId: matchId,
      playerAddress: playerAddress,
      opponentAddress: opponentAddress,
      stakeAmount: stakeAmount,
    );
  }
}

class _GameBody extends StatelessWidget {
  const _GameBody({required this.viewModel});

  final ChainReflexViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final target = viewModel.currentTarget;
    final shape = target['shape'] as String? ?? '';
    final color = target['color'] as String? ?? '';
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        children: [
          _ScoreRow(viewModel: viewModel),
          const SizedBox(height: 16),
          CountdownTimerWidget(
            seconds: viewModel.timeRemaining,
            isUrgent: viewModel.timeRemaining <= 10,
          ),
          const SizedBox(height: 20),
          Text(
            'Tap the $color $shape',
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Expanded(child: _TargetGrid(viewModel: viewModel)),
        ],
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({required this.viewModel});

  final ChainReflexViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${viewModel.playerScore}',
          style: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.success,
          ),
        ),
        const Spacer(),
        Text('VS', style: AppTextStyles.bodyLarge),
        const Spacer(),
        Text(
          '${viewModel.wrongTaps}',
          style: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.error,
          ),
        ),
      ],
    );
  }
}

class _TargetGrid extends StatelessWidget {
  const _TargetGrid({required this.viewModel});

  final ChainReflexViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final opts = viewModel.options;
    if (opts.length < 4) return const SizedBox.shrink();
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              _TargetCard(option: opts[0], onTap: viewModel.onTargetTap),
              const SizedBox(width: 12),
              _TargetCard(option: opts[1], onTap: viewModel.onTargetTap),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Row(
            children: [
              _TargetCard(option: opts[2], onTap: viewModel.onTargetTap),
              const SizedBox(width: 12),
              _TargetCard(option: opts[3], onTap: viewModel.onTargetTap),
            ],
          ),
        ),
      ],
    );
  }
}

class _TargetCard extends StatelessWidget {
  const _TargetCard({required this.option, required this.onTap});

  final Map<String, dynamic> option;
  final void Function(String shape, String color) onTap;

  static const Map<String, Color> _shapeColors = {
    'red': Color(0xFFE24B4A),
    'blue': Color(0xFF4A90E2),
    'green': Color(0xFF1D9E75),
    'yellow': Color(0xFFEF9F27),
  };

  @override
  Widget build(BuildContext context) {
    final shape = option['shape'] as String? ?? '';
    final color = option['color'] as String? ?? '';
    final fill = _shapeColors[color] ?? AppColors.textPrimary;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(shape, color),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          alignment: Alignment.center,
          child: _ShapeFigure(shape: shape, color: fill),
        ),
      ),
    );
  }
}

class _ShapeFigure extends StatelessWidget {
  const _ShapeFigure({required this.shape, required this.color});

  final String shape;
  final Color color;

  @override
  Widget build(BuildContext context) {
    switch (shape) {
      case 'circle':
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        );
      case 'square':
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: color,
          ),
        );
      case 'triangle':
        return CustomPaint(
          size: const Size(60, 60),
          painter: _TrianglePainter(color: color),
        );
      case 'diamond':
        return Transform.rotate(
          angle: pi / 4,
          child: Container(width: 45, height: 45, color: color),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _TrianglePainter extends CustomPainter {
  const _TrianglePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter old) => old.color != color;
}

class _GameOverOverlay extends StatelessWidget {
  const _GameOverOverlay({required this.viewModel});

  final ChainReflexViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final won = viewModel.isWinner;
    final stake = viewModel.stakeAmount;
    return Positioned.fill(
      child: ColoredBox(
        color: AppColors.background.withValues(alpha: 0.92),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              won ? 'Victory!' : 'Defeat',
              style: AppTextStyles.headlineLarge.copyWith(
                color: won ? AppColors.success : AppColors.error,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              won ? '+$stake REP' : '-$stake REP',
              style: AppTextStyles.bodyLarge,
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: VerraButton(
                label: 'Back to Home',
                onTap: viewModel.navigateToHome,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
