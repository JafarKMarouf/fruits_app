import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _customDivider()),
        const SizedBox(width: 18.88),
        AppTextWidget(
          text: AppLocalizations.of(context).or,
          style: AppTextStyles.styleSemiBold16,
        ),
        const SizedBox(width: 18.88),
        Expanded(child: _customDivider()),
      ],
    );
  }

  Widget _customDivider() {
    return Container(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFDCDEDE),
          ),
        ),
      ),
    );
  }
}
