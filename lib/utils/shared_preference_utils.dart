import 'package:get_storage/get_storage.dart';

class PreferenceUtils {
  static GetStorage getStorage = GetStorage();

  static String mode = 'mode';

  /// SET STRING PREFERENCE
  static Future setString({
    required String key,
    required String value,
  }) async {
    await getStorage.write(key, value);
  }

  static String getString() {
    return getStorage.read(mode) ?? "";
  }

  /// SET INT PREFERENCE
  static Future setInt({
    required String key,
    required int value,
  }) async {
    await getStorage.write(key, value);
  }

  static int getInt() {
    return getStorage.read(mode) ?? 0;
  }
}
