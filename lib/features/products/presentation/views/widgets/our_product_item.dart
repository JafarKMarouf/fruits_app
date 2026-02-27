import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

class OurProductItem extends StatelessWidget {
  final String title, image;

  const OurProductItem({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const ShapeDecoration(
            color: Color(0xFFF3F5F7),
            shape: OvalBorder(),
          ),
          child: Image.asset(image),
        ),
        const SizedBox(height: 2),
        AppTextWidget(
          text: title,
          style: AppTextStyles.styleSemiBold13.copyWith(
            color: AppColors.grayscale950,
          ),
        ),
      ],
    );
  }
}
