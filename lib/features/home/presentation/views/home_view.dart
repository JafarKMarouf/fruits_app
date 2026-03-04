import 'package:flutter/material.dart';
import 'package:fruits_app/features/home/presentation/views/best_selling_view.dart';
import 'package:fruits_app/features/home/presentation/views/notification_view.dart';
import 'package:fruits_app/features/home/presentation/views/search_view.dart';

import 'package:fruits_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = 'home-view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeViewBody(
        onShowMoreTapped: () =>
            Navigator.of(context).pushNamed(BestSellingView.routeName),
        onSearchTapped: () =>
            Navigator.of(context).pushNamed(SearchView.routeName),
        onNotificationTapped: () =>
            Navigator.of(context).pushNamed(NotificationView.routeName),
      ),
    );
  }
}
