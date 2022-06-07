import './env_config.dart';

class AppConfig {
  AppConfig._();

  static late String baseUrl;
  static late bool isProd;

  static void loadEnvironment() {
    final CustomEnv _env = EnvironmentConfig.customEnv;
    switch (_env) {
      case CustomEnv.development:
        baseUrl = '<YOUR DEVELOP SERVER URL>';
        isProd = false;
        break;
      case CustomEnv.stage:
        baseUrl = '<YOUR STAGE SERVER URL>';
        isProd = false;
        break;
      case CustomEnv.production:
        baseUrl = '<YOUR PRODUCTION SERVER URL>';
        isProd = true;
        break;
      default:
        break;
    }
  }
}
