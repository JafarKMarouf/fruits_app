import 'package:flutter/material.dart';
import '../../../features/home/presentation/views/best_selling_view.dart';
import '../../../features/home/presentation/views/notification_view.dart';
import '../../../features/home/presentation/views/search_view.dart';
import 'package:fruits_app/features/cart/presentation/views/cart_view.dart';
import 'package:fruits_app/features/home/presentation/views/home_view.dart';

import '../../../features/products/presentation/views/products_view.dart';
import '../../../features/profile/presentation/views/profile_view.dart';

class AppShellBody extends StatefulWidget {
  const AppShellBody({
    super.key,
    required this.currentIndex,
    required this.visitedTabs,
    required this.navigatorKeys,
  });

  final int currentIndex;
  final Set<int> visitedTabs;
  final List<GlobalKey<NavigatorState>> navigatorKeys;

  @override
  State<AppShellBody> createState() => _AppShellBodyState();
}

class _AppShellBodyState extends State<AppShellBody> {
  final List<Widget> _tabRoots = const [
    HomeView(),
    ProductsView(),
    CartView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.currentIndex,
      children: List.generate(
        _tabRoots.length,
        (index) => widget.visitedTabs.contains(index)
            ? Navigator(
                key: widget.navigatorKeys[index],
                onGenerateRoute: (settings) =>
                    _onGenerateTabRoute(settings, index),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Route<dynamic> _onGenerateTabRoute(RouteSettings settings, int tabIndex) {
    final Widget page = _resolveTabRoute(settings, tabIndex);

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, animation, _) => page,
      transitionsBuilder: (_, animation, _, child) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(0.04, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: child,
        ),
      ),
      transitionDuration: const Duration(milliseconds: 280),
    );
  }

  Widget _resolveTabRoute(RouteSettings settings, int tabIndex) {
    switch (settings.name) {
      // ── Tab 0: Home sub-routes ──────────────────────────────────────
      case BestSellingView.routeName:
        return const BestSellingView();
      case SearchView.routeName:
        return const SearchView();
      case NotificationView.routeName:
        return const NotificationView();

      default:
        return _tabRoots[tabIndex];
    }
  }
}
