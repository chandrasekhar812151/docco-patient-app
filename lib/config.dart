import 'package:doctor_patient/config/development.dart';
import 'package:doctor_patient/config/release.dart';

enum Flavor {
  DEVELOPMENT,
  RELEASE,
}

class Config {
  static Flavor? appFlavor;

  static String get apiUrl {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return  Release.apiUrl;
      case Flavor.DEVELOPMENT:
      default:
        return Development.apiUrl;
    }
  }

  static String getRazorPayApiKey() {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return Release.razorPayApiKey;
      case Flavor.DEVELOPMENT:
      default:
        return Development.razorPayApiKey;
    }
  }

  static String get agoraAppId {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return  Release.agoraAppId;
      case Flavor.DEVELOPMENT:
      default:
        return Development.agoraAppId;
    }
  }
}
