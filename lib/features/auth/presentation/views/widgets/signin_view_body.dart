import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/signin_form.dart';

class SigninViewBody extends StatelessWidget {
  const SigninViewBody({super.key});

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
              const SigninForm(),
            ],
          ),
        ),
      ),
    );
  }
}
