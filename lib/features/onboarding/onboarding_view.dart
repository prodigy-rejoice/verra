import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/app_colors.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StackedView<OnboardingViewModel> {
  const OnboardingView({super.key});

  @override
  Widget builder(
    BuildContext context,
    OnboardingViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Onboarding')),
    );
  }

  @override
  OnboardingViewModel viewModelBuilder(BuildContext context) =>
      OnboardingViewModel();

  @override
  void onViewModelReady(OnboardingViewModel viewModel) => viewModel.init();
}
