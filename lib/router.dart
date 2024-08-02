import 'package:flutter/material.dart';
import 'package:flutter_user_list/presentation/screens/home/home_screen.dart';
import 'package:flutter_user_list/presentation/screens/splash/splash_screen.dart';

class RouteNames {
  static const String splashScreen = "splashScreen";
  static const String homeScreen = "homeScreen";
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static BuildContext get context {
    if (navigatorKey.currentContext == null) {
      throw Exception('Navigator is not initialized');
    }

    return navigatorKey.currentContext!;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            builder: (navigationKey) => const SplashScreen());
      case RouteNames.homeScreen:
        return MaterialPageRoute(
            builder: (navigationKey) => const HomeScreen());
      default:
        return MaterialPageRoute(
            builder: (navigationKey) => const SplashScreen());
    }
  }
}
