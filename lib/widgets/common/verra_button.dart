import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class VerraButton extends StatelessWidget {
  const VerraButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback onTap;
  final bool isLoading;
  final bool isDisabled;
  final bool fullWidth;

  bool get _isInteractive => !isLoading && !isDisabled;

  @override
  Widget build(BuildContext context) {
    final button = Opacity(
      opacity: _isInteractive ? 1.0 : 0.5,
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: _isInteractive ? onTap : null,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 54,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.textPrimary,
                      ),
                    ),
                  )
                : Text(label, style: AppTextStyles.labelLarge),
          ),
        ),
      ),
    );

    if (!fullWidth) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}
