import 'package:get_storage/get_storage.dart';

class PreferenceUtils {
  static GetStorage getStorage = GetStorage();

  static String system = 'system';
  static String mode = 'mode';
  static String login = 'login';
  static String welcome = 'welcome';

  static String token = 'token';

  /// SET STRING PREFERENCE
  static Future setString({
    required String key,
    required String value,
  }) async {
    await getStorage.write(key, value);
  }

  static String getString({required String key}) {
    return getStorage.read(key) ?? "";
  }

  /// SET INT PREFERENCE
  static Future setInt({
    required String key,
    required int value,
  }) async {
    await getStorage.write(key, value);
  }

  static int getInt({required String key}) {
    return getStorage.read(key) ?? 0;
  }
}
