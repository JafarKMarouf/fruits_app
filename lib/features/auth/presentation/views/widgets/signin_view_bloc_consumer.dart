import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/build_messages_bar.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/widgets/build_app_bar.dart';
import 'package:fruits_app/core/widgets/custom_progress_hud.dart';
import 'package:fruits_app/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:fruits_app/features/home/presentation/views/home_view.dart';

class SigninViewBlocConsumer extends StatelessWidget {
  const SigninViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninFailure) {
          final locale = AppLocalizations.of(context);
          final localizedMessage = switch (state.message) {
            'invalidEmail' => locale.invalidEmail,
            'invalidCredential' => locale.invalidCredential,
            'networkRequestFailed' => locale.networkRequestFailed,
            _ => locale.genericError,
          };
          buildErrorBar(context, localizedMessage);
        }
        if (state is SigninSuccess) {
          buildSuccessMessage(
            context,
            AppLocalizations.of(context).loginSuccess,
          );
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeView.routeName,
              (route) => false,
            );
          });
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SigninLoading,
          child: Scaffold(
            appBar: buildAppBar(
              context,
              title: AppLocalizations.of(context).loginTitle,
            ),
            body: const SigninViewBody(),
          ),
        );
      },
    );
  }
}
