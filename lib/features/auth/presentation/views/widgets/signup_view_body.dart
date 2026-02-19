import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/build_error_bar.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/core/widgets/app_text_form_field.dart';
import 'package:fruits_app/core/widgets/password_field.dart';
import 'package:fruits_app/features/auth/domain/requests/create_user_request.dart';
import 'package:fruits_app/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/already_have_account.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String name, email, password;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool _showFieldShadows = true;
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
                showShadow: _showFieldShadows,
                onSaved: (value) => name = value!,
                hintText: AppLocalizations.of(context).fullName,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              AppTextFormField(
                showShadow: _showFieldShadows,
                onSaved: (value) => email = value!,
                hintText: AppLocalizations.of(context).emailAddress,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              PasswordField(
                onSaved: (value) => password = value!,
                showFieldShadows: _showFieldShadows,
              ),
              const SizedBox(height: 16),
              TermsAndConditions(
                changed: (value) {
                  isTermsAccepted = value;
                },
              ),
              const SizedBox(height: 33),
              AppPrimaryButton(
                text: AppLocalizations.of(context).signupTitle,
                onPressed: _onSubmit,
              ),
              const SizedBox(height: 26),
              const AlreadyHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (isTermsAccepted) {
        context.read<SignupCubit>().signup(
          request: CreateUserRequest(
            name: name,
            email: email,
            password: password,
          ),
        );
      } else {
        buildErrorBar(context, AppLocalizations.of(context).termsAcceptedError);
      }
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
        _showFieldShadows = false;
      });
    }
  }
}
