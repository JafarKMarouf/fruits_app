import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/custom_notification.dart';

class CustomMainAppBar extends StatelessWidget {
  const CustomMainAppBar({
    super.key,
    required this.title,
    this.isShowArrowBack = true,
    this.isShowNotification = true,
  });

  final String title;
  final bool isShowArrowBack, isShowNotification;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: isShowArrowBack,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(
                  side: BorderSide(width: 1, color: Color(0xFFF1F1F5)),
                ),
              ),
              child: Center(child: SvgPicture.asset(AppImages.imagesArrowBack)),
            ),
          ),
        ),
        AppTextWidget(
          title,
          style: AppTextStyles.styleBold19.copyWith(
            color: AppColors.grayscale950,
          ),
        ),
        Visibility(
          visible: isShowNotification,
          child: const CustomNotification(),
        ),
      ],
    );
  }
}
