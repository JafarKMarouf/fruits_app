import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: AppLocalizations.of(context).alreadyHaveAccount,
            style: AppTextStyles.styleSemiBold16.copyWith(
              color: AppColors.grayscale400,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
            text: AppLocalizations.of(context).loginTitle,
            style: AppTextStyles.styleSemiBold16.copyWith(
              color: AppColors.green1_500,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.right,
    );
  }
}
