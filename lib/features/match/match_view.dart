import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/app_colors.dart';
import 'match_viewmodel.dart';

class MatchView extends StackedView<MatchViewModel> {
  const MatchView({super.key});

  @override
  Widget builder(
    BuildContext context,
    MatchViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Match')),
    );
  }

  @override
  MatchViewModel viewModelBuilder(BuildContext context) => MatchViewModel();

  @override
  void onViewModelReady(MatchViewModel viewModel) => viewModel.init();
}
