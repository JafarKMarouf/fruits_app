import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/core/widgets/app_text_form_field.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/core/widgets/password_field.dart';
import 'package:fruits_app/features/auth/domain/requests/user_request.dart';
import 'package:fruits_app/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruits_app/features/auth/presentation/views/signup_view.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/dont_have_account.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/social_login.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email, password;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late bool _showFieldShadows = true;
  late bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: [
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: AppLocalizations.of(context).emailAddress,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                showShadow: _showFieldShadows,
                onSaved: (value) => email = value!,
              ),
              const SizedBox(height: 16),
              PasswordField(
                onSaved: (value) => password = value!,
                showFieldShadows: _showFieldShadows,
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
                onPressed: _onSubmit,
              ),
              const SizedBox(height: 33),
              DontHaveAccount(
                onTap: () {
                  Navigator.pushNamed(context, SignupView.routeName);
                  _clearForm();
                },
              ),
              const SizedBox(height: 33),
              const OrDivider(),
              const SizedBox(height: 21),
              SocialLogin(
                title: AppLocalizations.of(context).loginByGoogle,
                image: AppImages.imagesGoogle,
                onTap: () {
                  context.read<SigninCubit>().signInWithGoogle();
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _clearForm() {
    formKey.currentState!.reset();
    setState(() {
      autoValidateMode = AutovalidateMode.disabled;
      _showFieldShadows = true;
    });
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<SigninCubit>().signin(
        request: UserRequest(email: email, password: password),
      );
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
        _showFieldShadows = false;
      });
    }
  }
}
