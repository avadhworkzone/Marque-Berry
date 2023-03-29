import 'package:get_storage/get_storage.dart';

class PreferenceUtils {
  static GetStorage getStorage = GetStorage();

  static String mode = 'mode';

  /// LIGHT MODE
  static Future setLightMode({
    required String key,
    required String value,
  }) async {
    await getStorage.write(key, value);
  }

  static String getLightMode() {
    return getStorage.read(mode) ?? "light";
  }
}
