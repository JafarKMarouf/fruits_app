import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/features/onboarding/presentation/views/onboarding_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    handleNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SvgPicture.asset(AppImages.imagesPlant),
        ),
        SvgPicture.asset(AppImages.imagesLogo),
        SvgPicture.asset(AppImages.imagesSplashBottom, fit: BoxFit.fill),
      ],
    );
  }

  void handleNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, OnboardingView.routeName);
    });
  }
}
