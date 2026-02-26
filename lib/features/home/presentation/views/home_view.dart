import 'package:flutter/material.dart';
import 'package:fruits_app/core/helper/get_user.dart';
import 'package:fruits_app/core/services/get_it_service.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';
import 'package:fruits_app/features/auth/presentation/views/signin_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = 'home-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTextWidget(text: getUser().name),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await getIt<AuthRepo>().signOut();
            Navigator.pushNamedAndRemoveUntil(
              context,
              SigninView.routeName,
              (route) => false,
            );
          },
          icon: const Icon(Icons.logout),
        ),
      ),
    );
  }
}
