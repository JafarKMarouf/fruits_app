import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/core/widgets/app_text_form_field.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/dont_have_account.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/social_login.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            const SizedBox(height: 24),
            AppTextFormField(
              hintText: AppLocalizations.of(context).emailAddress,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              hintText: AppLocalizations.of(context).password,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: true,
              suffixIcon: const Icon(
                Icons.remove_red_eye,
                color: Color(0xFFC9CECF),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: AppTextWidget(
                    text: AppLocalizations.of(context).forgetPassword,
                    style: AppTextStyles.styleBold13.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 33),
            AppPrimaryButton(
              text: AppLocalizations.of(context).loginTitle,
              onPressed: () {},
            ),
            const SizedBox(height: 33),
            const DontHaveAccount(),
            const SizedBox(height: 33),
            const OrDivider(),
            const SizedBox(height: 21),
            SocialLogin(
              title: AppLocalizations.of(context).loginByGoogle,
              image: AppImages.imagesGoogle,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            SocialLogin(
              title: AppLocalizations.of(context).loginByApple,
              image: AppImages.imagesApple,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            SocialLogin(
              title: AppLocalizations.of(context).loginByFacebook,
              image: AppImages.imagesFacebook,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
