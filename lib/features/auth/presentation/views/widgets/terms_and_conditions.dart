import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/custom_checkbox.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key, required this.changed});

  final ValueChanged<bool> changed;

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        CustomCheckbox(
          isChecked: isAccepted,
          onChecked: (value) {
            setState(() {
              isAccepted = value;
              widget.changed(value);
            });
          },
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context).byCreatingAccount,
                  style: AppTextStyles.styleBold13.copyWith(
                    color: AppColors.grayscale400,
                  ),
                ),
                TextSpan(
                  text: AppLocalizations.of(context).termsAndConditions,
                  style: AppTextStyles.styleBold13.copyWith(
                    color: AppColors.green1_600,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
