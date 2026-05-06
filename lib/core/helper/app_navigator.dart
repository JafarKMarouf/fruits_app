import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState get _navigator {
    assert(
      navigatorKey.currentState != null,
      'AppNavigator: navigatorKey is not attached to MaterialApp yet.',
    );
    return navigatorKey.currentState!;
  }

  static Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      _navigator.pushNamed<T>(routeName, arguments: arguments);

  static Future<T?> pushNamedAndRemoveUntil<T>(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) => _navigator.pushNamedAndRemoveUntil<T>(
    routeName,
    predicate,
    arguments: arguments,
  );

  static void pop<T>([T? result]) => _navigator.pop<T>(result);
}
