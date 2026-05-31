import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/app_colors.dart';
import 'match_result_viewmodel.dart';

class MatchResultView extends StackedView<MatchResultViewModel> {
  const MatchResultView({super.key});

  @override
  Widget builder(
    BuildContext context,
    MatchResultViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Match Result')),
    );
  }

  @override
  MatchResultViewModel viewModelBuilder(BuildContext context) =>
      MatchResultViewModel();

  @override
  void onViewModelReady(MatchResultViewModel viewModel) => viewModel.init();
}
