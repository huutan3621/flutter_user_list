import 'package:flutter/material.dart';
import 'package:flutter_user_list/presentation/screens/home/home_screen.dart';
import 'package:flutter_user_list/presentation/screens/splash/splash_screen.dart';

class RouteNames {
  static const String splashScreen = "splashScreen";
  static const String homeScreen = "homeScreen";
}

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
