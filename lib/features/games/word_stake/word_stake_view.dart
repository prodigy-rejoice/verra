import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/app_colors.dart';
import 'word_stake_viewmodel.dart';

class WordStakeView extends StackedView<WordStakeViewModel> {
  const WordStakeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    WordStakeViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Word Stake')),
    );
  }

  @override
  WordStakeViewModel viewModelBuilder(BuildContext context) =>
      WordStakeViewModel();

  @override
  void onViewModelReady(WordStakeViewModel viewModel) => viewModel.init();
}
