import './common_helpers.dart';

class EnvironmentConfig {
  EnvironmentConfig._();
  static CustomEnv customEnv = CommonHelpers.enumFromString(
    CustomEnv.values,
    const String.fromEnvironment(
      'CUSTOM_ENV',
      defaultValue: 'development',
    ),
  )!;
}

enum CustomEnv { development, stage, production }
