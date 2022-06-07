import 'package:package_info_plus/package_info_plus.dart';

import '../utils/device_info.dart';

import './shared_preferences.service.dart';

class AppAndDeviceInfoService {
  AppAndDeviceInfoService._();
  static Map<String, dynamic>? deviceInfo;
  static Map<String, dynamic>? memoryInfo;
  static late PackageInfo packageInfo;

  static Future<void> initiate() async {
    packageInfo = await PackageInfo.fromPlatform();
    deviceInfo = await DeviceInfo.getDeviceInfo();
    memoryInfo = await DeviceInfo.getDeviceMemoryInfo();
    if (deviceInfo != null || memoryInfo != null) {
      deviceInfo!.addAll(memoryInfo!);
      SharedPreferencesService.setDeviceData(deviceInfo!);
    }
  }

  static String getCurrentOS() {
    return deviceInfo!['os'].toString().toUpperCase();
  }

  static String getAppVersion() {
    return packageInfo.version;
  }

  static String getAppBuildNumber() {
    return packageInfo.buildNumber;
  }
}
