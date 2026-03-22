import 'package:flutter/material.dart';
import 'package:fruits_app/features/auth/presentation/views/signin_view.dart';
import 'package:fruits_app/features/auth/presentation/views/signup_view.dart';
import 'package:fruits_app/features/onboarding/presentation/views/onboarding_view.dart';

import '../../features/checkout/presentation/views/checkout_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../widgets/app_text_widget.dart';
import '../widgets/bottom_nav_bar/app_shell.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return _fade(const SplashView());
    case OnboardingView.routeName:
      return _fade(const OnboardingView());
    case SigninView.routeName:
      return _slide(const SigninView());
    case SignupView.routeName:
      return _slide(const SignupView());

    case AppShell.routeName:
      return _fade(const AppShell());

    case CheckoutView.routeName:
      return _slide(const CheckoutView());

    default:
      return _fade(
        const Scaffold(
          body: Center(child: AppTextWidget('404 – Route not found')),
        ),
      );
  }
}

PageRoute<T> _fade<T>(Widget page) => PageRouteBuilder<T>(
  pageBuilder: (_, _, _) => page,
  transitionsBuilder: (_, animation, _, child) => FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
    child: child,
  ),
  transitionDuration: const Duration(milliseconds: 350),
);

PageRoute<T> _slide<T>(Widget page) => PageRouteBuilder<T>(
  pageBuilder: (_, _, _) => page,
  transitionsBuilder: (_, animation, _, child) => SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1.0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
    child: child,
  ),
  transitionDuration: const Duration(milliseconds: 350),
);
