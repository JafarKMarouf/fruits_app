import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/signup_form.dart';

import '../../../../../core/utils/styles/app_images.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kTopPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 20,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              SvgPicture.asset(AppImages.imagesLogo),
              const SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}
