import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: AppLocalizations.of(context).dontHaveAccount,
            style: AppTextStyles.styleSemiBold16.copyWith(
              color: AppColors.grayscale400,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: AppLocalizations.of(context).doCreateAccount,
            style: AppTextStyles.styleSemiBold16.copyWith(
              color: AppColors.green1_500,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
