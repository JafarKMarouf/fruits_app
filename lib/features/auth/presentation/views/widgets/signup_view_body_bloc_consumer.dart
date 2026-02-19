import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/build_error_bar.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/widgets/build_app_bar.dart';
import 'package:fruits_app/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupFailure) {
          final locale = AppLocalizations.of(context);
          final localizedMessage = switch (state.message) {
            'weakPassword' => locale.weakPassword,
            'emailAlreadyInUse' => locale.emailAlreadyInUse,
            'networkRequestFailed' => locale.networkRequestFailed,
            'invalidEmail' => locale.invalidEmail,
            _ => locale.genericError,
          };
          buildErrorBar(context, localizedMessage);
        }
        if (state is SignupSuccess) {
          buildSuccessMessage(
            context,
            AppLocalizations.of(context).successRegister,
          );
          Future.delayed(const Duration(milliseconds: 200), () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading,
          child: Scaffold(
            appBar: buildAppBar(
              context,
              title: AppLocalizations.of(context).signupTitle,
            ),
            body: const SignupViewBody(),
          ),
        );
      },
    );
  }
}
