import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/app_colors.dart';
import 'math_duel_viewmodel.dart';

class MathDuelView extends StackedView<MathDuelViewModel> {
  const MathDuelView({super.key});

  @override
  Widget builder(
    BuildContext context,
    MathDuelViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Math Duel')),
    );
  }

  @override
  MathDuelViewModel viewModelBuilder(BuildContext context) =>
      MathDuelViewModel();

  @override
  void onViewModelReady(MathDuelViewModel viewModel) => viewModel.init();
}
