class NavigationResponse<T> {
  bool success;
  String routeName;
  T? result;

  NavigationResponse({
    required this.routeName,
    required this.success,
    this.result,
  });

  factory NavigationResponse.success(String routeName, {T? result}) =>
      NavigationResponse<T>(
        routeName: routeName,
        result: result,
        success: true,
      );

  factory NavigationResponse.failure(String routeName, {T? result}) =>
      NavigationResponse<T>(
        routeName: routeName,
        result: result,
        success: false,
      );
}
