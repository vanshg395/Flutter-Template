import 'package:flutter/material.dart';

import './services/routing/routes.dart';
import './services/navigation.service.dart';
import './services/routing/routing.service.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Template',
      onGenerateRoute: RoutingService.generateRoute,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: Routes.splash,
    );
  }
}
