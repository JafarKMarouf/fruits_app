import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/core/widgets/app_text_form_field.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/already_have_account.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

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
              hintText: AppLocalizations.of(context).fullName,
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
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
            const TermsAndConditions(),
            const SizedBox(height: 33),
            AppPrimaryButton(
              text: AppLocalizations.of(context).signupTitle,
              onPressed: () {},
            ),
            const SizedBox(height: 26),

            const AlreadyHaveAccount(),
          ],
        ),
      ),
    );
  }
}
