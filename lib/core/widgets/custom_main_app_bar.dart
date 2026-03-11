import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/custom_notification.dart';

class CustomMainAppBar extends StatelessWidget {
  const CustomMainAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Navigator.canPop(context)
            ? GestureDetector(
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
                  child: Center(
                    child: SvgPicture.asset(AppImages.imagesArrowBack),
                  ),
                ),
              )
            : const SizedBox(),
        AppTextWidget(
          text: title,
          style: AppTextStyles.styleBold19.copyWith(
            color: AppColors.grayscale950,
          ),
        ),
        const CustomNotification(),
      ],
    );
  }
}
