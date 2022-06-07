import 'package:flutter/material.dart';

import './routes.dart';

import '../../modules/splash/splash.screen.dart';

class RoutingService {
  RoutingService._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final Map<String, dynamic>? queryParams =
        settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      default:
        return null;
    }
  }
}
