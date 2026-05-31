import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/common/verra_button.dart';
import 'auth_viewmodel.dart';

class AuthView extends StackedView<AuthViewModel> {
  const AuthView({super.key});

  static const String _reassurance =
      'Your reputation lives on Sui. No crypto knowledge needed.';

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const Text(AppStrings.appName, style: AppTextStyles.displayLarge),
              const SizedBox(height: 12),
              const Text(AppStrings.tagline, style: AppTextStyles.bodyMedium),
              const Spacer(flex: 3),
              VerraButton(
                label: AppStrings.signInWithGoogle,
                isLoading: viewModel.isSigningIn,
                onTap: viewModel.signInWithGoogle,
              ),
              const SizedBox(height: 16),
              const Text(
                _reassurance,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AuthViewModel viewModelBuilder(BuildContext context) => AuthViewModel();

  @override
  void onViewModelReady(AuthViewModel viewModel) => viewModel.init();
}
