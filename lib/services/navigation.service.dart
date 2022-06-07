import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/shared/navigation_response.model.dart';

class NavigationService {
  NavigationService._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get currentContext => navigatorKey.currentContext;

  static NavigatorState? get currentState => navigatorKey.currentState;

  static Function? pendingRedirect;

  static Future<NavigationResponse<dynamic>?> pushNamed(
    String routeName, {
    dynamic arguments,
  }) {
    return navigatorKey.currentState!.pushNamed<NavigationResponse<dynamic>?>(
        routeName,
        arguments: arguments);
  }

  static Future<NavigationResponse<dynamic>?> push(
      Route<NavigationResponse<dynamic>?> route) {
    return navigatorKey.currentState!.push<NavigationResponse<dynamic>?>(route);
  }

  static Future<dynamic> pushReplacement(Route route) {
    return navigatorKey.currentState!.pushReplacement(route);
  }

  static Future<dynamic> pushAndRemoveUntil(
      Route route, bool Function(Route<dynamic>) predicate) {
    return navigatorKey.currentState!.pushAndRemoveUntil(route, predicate);
  }

  static Future<dynamic> pushReplacementNamed(
    String routeName, {
    dynamic arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
      String routeName, bool Function(Route<dynamic>) predicate,
      {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  static void goBack<T>([NavigationResponse<T>? result]) =>
      navigatorKey.currentState!.pop<NavigationResponse<T?>?>(result);

  static void goBackUntil(RoutePredicate predicate) =>
      navigatorKey.currentState!.popUntil(predicate);
}
