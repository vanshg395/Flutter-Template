class ApiResponse<T> {
  T? result;
  bool success;
  int statusCode;
  Error? error;

  ApiResponse._({
    this.result,
    required this.success,
    required this.statusCode,
    this.error,
  });

  factory ApiResponse.success({
    required int statusCode,
    required T result,
  }) =>
      ApiResponse<T>._(
        success: true,
        statusCode: statusCode,
        result: result,
      );

  factory ApiResponse.error({
    required int statusCode,
    required Error error,
  }) =>
      ApiResponse<T>._(
        success: false,
        statusCode: statusCode,
        error: error,
      );
}

class Error {
  ErrorCause cause;
  String title;
  String description;

  Error({
    this.cause = ErrorCause.NO_INTERNET,
    this.title = "",
    this.description = "",
  });

  factory Error.noInternet(String errorTitle, {String? errorDescription}) =>
      Error(
        cause: ErrorCause.NO_INTERNET,
        title: errorTitle,
        description: errorDescription ?? "",
      );

  factory Error.apiError(String errorTitle, {String? errorDescription}) =>
      Error(
        cause: ErrorCause.API_ERROR,
        title: errorTitle,
        description: errorDescription ?? "",
      );
}

enum ErrorCause {
  NO_INTERNET,
  API_ERROR,
}
