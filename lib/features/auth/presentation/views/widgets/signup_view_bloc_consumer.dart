import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/show_messages_bar.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/widgets/build_app_bar.dart';
import 'package:fruits_app/core/widgets/custom_progress_hud.dart';
import 'package:fruits_app/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/signup_view_body.dart';

class SignupViewBlocConsumer extends StatelessWidget {
  const SignupViewBlocConsumer({super.key});

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
          showErrorBar(context, localizedMessage);
        }
        if (state is SignupSuccess) {
          showSuccessMessage(
            context,
            AppLocalizations.of(context).registerSuccess,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SignupLoading,
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
