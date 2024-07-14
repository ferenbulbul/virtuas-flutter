class PrivacyUtils {
  static String maskName(String name) {
    if (name.length <= 2) {
      return '*'.padRight(name.length, '*');
    } else {
      String maskedName = name.substring(0, 1);
      for (int i = 1; i < name.length - 1; i++) {
        maskedName += '*';
      }
      maskedName += name.substring(name.length - 1);
      return maskedName;
    }
  }
}
