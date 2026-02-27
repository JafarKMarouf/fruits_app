import 'package:flutter/material.dart';
import 'package:fruits_app/features/home/presentation/views/best_selling_view.dart';
import 'package:fruits_app/features/home/presentation/views/notification_view.dart';
import 'package:fruits_app/features/home/presentation/views/search_view.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = 'home-view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final GlobalKey<NavigatorState> _nestedNavKey = GlobalKey<NavigatorState>();

  Future<bool> _onWillPop() async {
    final nestedNav = _nestedNavKey.currentState;
    if (nestedNav != null && nestedNav.canPop()) {
      nestedNav.pop();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => _onWillPop(),
      child: Scaffold(
        body: Navigator(
          key: _nestedNavKey,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case BestSellingView.routeName:
                return _fadeRoute(const BestSellingView());
              case SearchView.routeName:
                return _fadeRoute(const SearchView());
              case NotificationView.routeName:
                return _fadeRoute(const NotificationView());
              default:
                return _fadeRoute(
                  HomeViewBody(
                    onShowMoreTapped: _navigateToBestSelling,
                    onSearchTapped: _navigateToSearch,
                    onNotificationTapped: _navigateToNotification,
                  ),
                );
            }
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }

  void _navigateToBestSelling() {
    _nestedNavKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => const BestSellingView(),
        settings: const RouteSettings(name: BestSellingView.routeName),
      ),
    );
  }

  void _navigateToSearch() {
    _nestedNavKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => const SearchView(),
        settings: const RouteSettings(name: SearchView.routeName),
      ),
    );
  }

  void _navigateToNotification() {
    _nestedNavKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => const NotificationView(),
        settings: const RouteSettings(name: NotificationView.routeName),
      ),
    );
  }

  PageRoute _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
