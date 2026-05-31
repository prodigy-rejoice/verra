import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/app_colors.dart';
import 'pattern_breaker_viewmodel.dart';

class PatternBreakerView extends StackedView<PatternBreakerViewModel> {
  const PatternBreakerView({super.key});

  @override
  Widget builder(
    BuildContext context,
    PatternBreakerViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Pattern Breaker')),
    );
  }

  @override
  PatternBreakerViewModel viewModelBuilder(BuildContext context) =>
      PatternBreakerViewModel();

  @override
  void onViewModelReady(PatternBreakerViewModel viewModel) => viewModel.init();
}
