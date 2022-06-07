import 'dart:convert';

import '../../services/app_and_device_info.service.dart';

class UserAgent {
  String? deviceId;
  String? device;
  String? appVersion;
  String? deviceType;
  String? os;
  String? timezone;

  UserAgent() {
    deviceId = AppAndDeviceInfoService.deviceInfo?["androidId"] ??
        AppAndDeviceInfoService.deviceInfo?["identifierForVendor"];
    if (AppAndDeviceInfoService.deviceInfo?['os'] == "Android") {
      device =
          "${AppAndDeviceInfoService.deviceInfo?['brand']} ${AppAndDeviceInfoService.deviceInfo?['model']} v${AppAndDeviceInfoService.deviceInfo?['version.release']}";
    } else if (AppAndDeviceInfoService.deviceInfo?['os'] == "iOS") {
      device =
          "${AppAndDeviceInfoService.deviceInfo?['name']} ${AppAndDeviceInfoService.deviceInfo?['model']} ${AppAndDeviceInfoService.deviceInfo?['version.systemName']} v${AppAndDeviceInfoService.deviceInfo?['version.systemVersion']}";
    } else {
      device = "Unknown Device";
    }
    appVersion = AppAndDeviceInfoService.packageInfo.version;
    deviceType = 'APP';
    os = AppAndDeviceInfoService.deviceInfo?['os'];
    timezone = DateTime.now().timeZoneName;
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceId': deviceId,
      'device': device,
      'appVersion': appVersion,
      'deviceType': deviceType,
      'os': os,
      'timezone': timezone,
    };
  }

  String toJson() => json.encode(toMap());
}
