import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._();

  static late SharedPreferences _prefs;

  static Future<bool> initiate() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future<bool> clear() => _prefs.clear();

  static Future<bool> setAccessToken(String accessToken) =>
      _prefs.setString('accessToken', 'Bearer $accessToken');

  static Future<bool> removeAccessToken() async =>
      await _prefs.remove('accessToken');

  static Future<bool> setUserId(String userId) =>
      _prefs.setString('accessToken', userId);

  static Future<bool> setDeviceData(Map<String, dynamic> deviceInfo) =>
      _prefs.setString("deviceInfo", jsonEncode(deviceInfo));

  static String? get accessToken => _prefs.getString('accessToken');

  static String? get userId => _prefs.getString('userId');
}
