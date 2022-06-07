import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../utils/common_helpers.dart';
import '../utils/app_config.dart';

class ApiHandler {
  ApiHandler._();

  static Future<http.Response> sendGetRequest({
    required String endpoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri uri = Uri.https(AppConfig.baseUrl, endpoint, queryParams);
    http.Response response = await http.get(
      uri,
      headers: {
        ...CommonHelpers.getApiHeaders(),
        if (headers != null) ...headers,
      },
    );
    log("GET >>>>> $endpoint >>>>> ${response.statusCode}");
    return response;
  }

  static Future<http.Response> sendPostRequest({
    required String endpoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Object? body,
  }) async {
    Uri uri = Uri.https(AppConfig.baseUrl, endpoint, queryParams);
    http.Response response = await http.post(
      uri,
      headers: {
        ...CommonHelpers.getApiHeaders(),
        if (headers != null) ...headers,
      },
      body: jsonEncode(body),
    );
    if (!AppConfig.isProd) {
      log("POST >>>>> $endpoint >>>>> ${response.statusCode}");
    }
    return response;
  }

  static Future<http.Response> sendPatchRequest({
    required String endpoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Object? body,
  }) async {
    Uri uri = Uri.https(AppConfig.baseUrl, endpoint, queryParams);
    http.Response response = await http.patch(
      uri,
      headers: {
        ...CommonHelpers.getApiHeaders(),
        if (headers != null) ...headers,
      },
      body: jsonEncode(body),
    );
    if (!AppConfig.isProd) {
      log("PATCH >>>>> $endpoint >>>>> ${response.statusCode}");
    }
    return response;
  }

  static Future<http.Response> sendPutRequest({
    required String endpoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Object? body,
  }) async {
    Uri uri = Uri.https(AppConfig.baseUrl, endpoint, queryParams);
    http.Response response = await http.put(
      uri,
      headers: {
        ...CommonHelpers.getApiHeaders(),
        if (headers != null) ...headers,
      },
      body: jsonEncode(body),
    );
    if (!AppConfig.isProd) {
      log("PUT >>>>> $endpoint >>>>> ${response.statusCode}");
    }
    return response;
  }

  static Future<http.Response> sendDeleteRequest({
    required String endpoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Object? body,
  }) async {
    Uri uri = Uri.https(AppConfig.baseUrl, endpoint, queryParams);
    http.Response response = await http.delete(
      uri,
      headers: {
        ...CommonHelpers.getApiHeaders(),
        if (headers != null) ...headers,
      },
      body: jsonEncode(body),
    );
    if (!AppConfig.isProd) {
      log("DELETE >>>>> $endpoint >>>>> ${response.statusCode}");
    }
    return response;
  }
}
