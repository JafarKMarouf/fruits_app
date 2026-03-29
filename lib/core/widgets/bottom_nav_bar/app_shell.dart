import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/get_user.dart';
import 'package:fruits_app/core/services/get_it_service.dart';
import 'package:fruits_app/core/widgets/bottom_nav_bar/app_shell_body.dart';
import 'package:fruits_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'custom_bottom_nav_bar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  static const routeName = 'app-shell';

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;
  final Set<int> _visitedTabs = {0};

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    4,
    (_) => GlobalKey<NavigatorState>(),
  );

  void _onTabTapped(int index) {
    if (index == _currentIndex) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _visitedTabs.add(index);
        _currentIndex = index;
      });
    }
  }

  Future<bool> _onWillPop() async {
    final activeNavigator = _navigatorKeys[_currentIndex].currentState;
    if (activeNavigator != null && activeNavigator.canPop()) {
      activeNavigator.pop();
      return false;
    }
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartCubit>()..syncCart(getUser().uId),
      child: PopScope(
        canPop: false,
        onPopInvoked: (_) => _onWillPop(),
        child: Scaffold(
          body: AppShellBody(
            currentIndex: _currentIndex,
            visitedTabs: _visitedTabs,
            navigatorKeys: _navigatorKeys,
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: _currentIndex,
            onItemTapped: _onTabTapped,
          ),
        ),
      ),
    );
  }
}
