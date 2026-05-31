import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/app_colors.dart';
import 'chain_reflex_viewmodel.dart';

class ChainReflexView extends StackedView<ChainReflexViewModel> {
  const ChainReflexView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ChainReflexViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Chain Reflex')),
    );
  }

  @override
  ChainReflexViewModel viewModelBuilder(BuildContext context) =>
      ChainReflexViewModel();

  @override
  void onViewModelReady(ChainReflexViewModel viewModel) => viewModel.init();
}
