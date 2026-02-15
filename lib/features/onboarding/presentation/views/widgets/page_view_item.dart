import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/onboarding/presentation/views/widgets/onboarding_images.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    required this.backgroundImage,
    required this.title,
    required this.subTitle,
    this.backgroundColor,
    required this.isVisible 
  });

  final String image, backgroundImage, subTitle;
  final Widget title;
  final Color? backgroundColor;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: OnboardingImages(
            image: image,
            backgroundImage: backgroundImage,
            isVisible: isVisible,
          ),
        ),
        const SizedBox(height: 64),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            title,
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppTextWidget(
                text: subTitle,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: AppTextStyles.styleSemiBold13.copyWith(
                  color: AppColors.grayscale500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
