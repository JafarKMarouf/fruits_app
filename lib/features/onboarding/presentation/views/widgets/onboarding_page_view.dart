import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/onboarding/presentation/views/widgets/page_view_item.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          isVisible: true,
          backgroundImage: AppImages.imagesBackgroundOnboarding1,
          image: AppImages.imagesFruitBasket,
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: locale.onBoardingWelcomeTitle,
                  style: AppTextStyles.styleBold23.copyWith(
                    color: AppColors.grayscale950,
                  ),
                ),
                TextSpan(
                  text: 'Fruit',
                  style: AppTextStyles.styleBold23.copyWith(
                    color: AppColors.green1_500,
                  ),
                ),
                TextSpan(
                  text: 'HUB',
                  style: AppTextStyles.styleBold23.copyWith(
                    color: AppColors.orange500,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          subTitle: AppLocalizations.of(context).onBoardingWelcomeSubTitle,
        ),
        PageViewItem(
          isVisible: false,
          backgroundImage: AppImages.imagesBackgroundOnboarding2,
          image: AppImages.imagesPineappleCuate,
          title: AppTextWidget(
            text: locale.onBoardingSearchTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.styleBold23.copyWith(
              color: AppColors.grayscale950,
            ),
          ),
          subTitle: locale.onBoardingSearchSubTitle,
        ),
      ],
    );
  }
}
