import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/app_colors.dart';
import 'crypto_trivia_viewmodel.dart';

class CryptoTriviaView extends StackedView<CryptoTriviaViewModel> {
  const CryptoTriviaView({super.key});

  @override
  Widget builder(
    BuildContext context,
    CryptoTriviaViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Crypto Trivia')),
    );
  }

  @override
  CryptoTriviaViewModel viewModelBuilder(BuildContext context) =>
      CryptoTriviaViewModel();

  @override
  void onViewModelReady(CryptoTriviaViewModel viewModel) => viewModel.init();
}
