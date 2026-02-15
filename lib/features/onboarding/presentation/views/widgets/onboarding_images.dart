import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/auth/presentation/views/login_view.dart';

class OnboardingImages extends StatelessWidget {
  const OnboardingImages({
    super.key,
    required this.image,
    required this.backgroundImage,
    required this.isVisible,
  });

  final String image, backgroundImage;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(backgroundImage, fit: BoxFit.fill),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 70,
          bottom: MediaQuery.of(context).padding.bottom,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(image, fit: BoxFit.scaleDown),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 12,
          right: 20,
          child: Visibility(
            visible: isVisible,
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, LoginView.routeName);
                },
                child: AppTextWidget(
                  text: AppLocalizations.of(context).skip,
                  style: AppTextStyles.styleRegular13.copyWith(
                    color: AppColors.grayscale400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
