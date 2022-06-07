import 'package:flutter/material.dart';

import './my_app.dart';

import '../utils/app_config.dart';

import './services/shared_preferences.service.dart';
import './services/app_and_device_info.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.initiate();
  await AppAndDeviceInfoService.initiate();
  AppConfig.loadEnvironment();
  runApp(const MyApp());
}
