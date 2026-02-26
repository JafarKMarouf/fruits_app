import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/services/shared_preferences_service.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/features/auth/presentation/views/signin_view.dart';
import 'package:fruits_app/features/onboarding/presentation/views/widgets/onboarding_page_view.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    _pageController.addListener(() {
      currentPage = _pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: OnboardingPageView(pageController: _pageController)),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            color: currentPage == 1
                ? AppColors.green1_500
                : AppColors.green1_500.withOpacity(.5),
            activeColor: AppColors.green1_500,
          ),
        ),
        const SizedBox(height: 29),
        Visibility(
          visible: currentPage == 1,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: AppPrimaryButton(
              onPressed: () {
                SharedPreferencesService.setBool(kIsOnBoardingSeen, true);
                Navigator.pushReplacementNamed(context, SigninView.routeName);
              },
              text: AppLocalizations.of(context).startNowButton,
              textStyle: AppTextStyles.styleBold16.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 43),
      ],
    );
  }
}
