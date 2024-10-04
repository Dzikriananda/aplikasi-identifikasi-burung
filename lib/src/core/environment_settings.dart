class EnvironmentSettings {


  static const DEVELOPMENT_URL = 'https://ea49-182-3-45-15.ngrok-free.app/';
  static const STAGING_URL = 'http://10.1.12.28:8080';
  static const PRODUCTION_URL = 'http://117.53.45.158:3000/';

  static String get baseUrl {
    switch (_environment) {
      case EnvironmentMode.development:
        return DEVELOPMENT_URL;
      case EnvironmentMode.staging:
        return STAGING_URL;
      case EnvironmentMode.production:
        return PRODUCTION_URL;
      default:
        throw UnimplementedError(
            'base url for current environment unimplemented');
    }
  }

  // Environment mode
  //
  static EnvironmentMode _environment = EnvironmentMode.production;
  static bool get isStaging => _environment == EnvironmentMode.staging;
  static bool get isProduction => _environment == EnvironmentMode.production;

  static EnvironmentMode get environment => _environment;
  static setEnvironment(EnvironmentMode value) => _environment = value;

  // Database
  //
  static const String dbDir = 'jmarsip-db';
  static const int schemaVersion = 31;

  // Firebase
  //
  static final firebaseId = '';

  // Others
  //
  static final oneSignalAPIKey = "f8e1698c-f079-4eaa-b8a7-f8ab6da7a8a0";
  static final mapAPIKey = '';

  static final fbID = '';
  static final twitterID = '';
  static final googleID = '';
  static final linkedInID = '';
  static final whatsApp = "+628119914080";
  static final linkGuide =
      'https://drive.google.com/file/d/11R2jkvafblycXhQpYY-ylCf7_CSj3LaP/view?usp=sharing';

  // Additional

  static String get webBaseUrl {
    final url = Uri.tryParse(baseUrl)!;
    final port = ":${url.port}";
    final origin = url.origin.replaceAll(port, "");
    return origin;
  }
}

enum EnvironmentMode { development, staging, production }
