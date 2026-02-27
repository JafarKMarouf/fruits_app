import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

class NoResultBody extends StatelessWidget {
  const NoResultBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        SvgPicture.asset(AppImages.imagesSearchWithoutResult),
        const SizedBox(height: 20),
        AppTextWidget(
          text: 'البحث',
          style: AppTextStyles.styleBold16.copyWith(
            color: AppColors.grayscale600,
          ),
        ),
        AppTextWidget(
          text: 'عفوًا... هذه المعلومات غير متوفرة للحظة',
          style: AppTextStyles.styleRegular13.copyWith(
            color: AppColors.grayscale400,
          ),
        ),
      ],
    );
  }
}
