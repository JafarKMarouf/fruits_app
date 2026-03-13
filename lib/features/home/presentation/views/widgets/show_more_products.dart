import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

class ShowMoreProducts extends StatelessWidget {
  const ShowMoreProducts({super.key, this.onTap, this.isShowMore = true});

  final VoidCallback? onTap;
  final bool isShowMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(
          'منتجاتنا',
          style: AppTextStyles.styleBold16.copyWith(
            color: AppColors.grayscale950,
          ),
        ),
        Visibility(
          visible: isShowMore,
          child: TextButton(
            onPressed: onTap,
            child: AppTextWidget(
              'المزيد',
              style: AppTextStyles.styleRegular13.copyWith(
                color: AppColors.grayscale400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
