import 'package:flutter/material.dart';
import 'package:fruits_app/core/services/get_it_service.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';
import 'package:fruits_app/features/auth/presentation/views/signin_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = 'profile-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _handleSignOut(context),
          icon: const Icon(Icons.exit_to_app),
        ),
      ),
    );
  }

  Future<void> _handleSignOut(BuildContext context) async {
    await getIt<AuthRepo>().signOut();

    if (!context.mounted) return;

    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamedAndRemoveUntil(SigninView.routeName, (route) => false);
  }
}
