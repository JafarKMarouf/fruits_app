import 'package:flutter/material.dart';
import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:fruits_app/core/widgets/build_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = 'home-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: AppLocalizations.of(context).homeTitle,
      ),
    );
  }
}
