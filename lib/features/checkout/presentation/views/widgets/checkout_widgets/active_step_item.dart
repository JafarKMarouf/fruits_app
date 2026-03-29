import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

class ActiveStepItem extends StatelessWidget {
  const ActiveStepItem({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,

      children: [
        const CircleAvatar(
          radius: 11.5,
          backgroundColor: AppColors.green1_500,
          child: Icon(Icons.check, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 4),
        AppTextWidget(
          title,
          style: AppTextStyles.styleBold13.copyWith(
            color: AppColors.green1_500,
          ),
        ),
      ],
    );
  }
}
