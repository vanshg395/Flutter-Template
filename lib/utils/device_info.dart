import 'dart:io';

import 'package:flutter/services.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:memory_info/memory_info.dart';

import '../utils/connection_status_singleton.dart';

class DeviceInfo {
  DeviceInfo._();

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static Map<String, dynamic>? deviceData;
  static String connectionSource = '';
  static Map<String, dynamic>? deviceMemoryInfo;

  static Future<Map<String, dynamic>?> getDeviceInfo() async {
    try {
      connectionSource = await connectionStatus.getConnectivitySource();
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    return deviceData;
  }

  static Future<Map<String, dynamic>?> getDeviceMemoryInfo() async {
    Memory? memory;
    DiskSpace? diskSpace;
    try {
      memory = await MemoryInfoPlugin().memoryInfo;
      diskSpace = await MemoryInfoPlugin().diskSpace;
      deviceMemoryInfo = _readMemoryData(memory, diskSpace);
    } on PlatformException {
      deviceMemoryInfo = <String, dynamic>{
        "memory_error": "Failed to get device memory info,"
      };
    }
    return deviceMemoryInfo;
  }

  static Map<String, dynamic> _readMemoryData(
      Memory memory, DiskSpace diskSpace) {
    return <String, dynamic>{
      'total_ram': memory.totalMem,
    };
  }

  static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'os': "Android",
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
      'connectionSource': connectionSource,
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'os': 'IOS',
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
      'connectionSource': connectionSource,
    };
  }
}
