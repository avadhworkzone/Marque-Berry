import 'package:get_storage/get_storage.dart';
import 'package:socialv/utils/const_utils.dart';

class PreferenceUtils {
  static GetStorage getStorage = GetStorage();

  static String system = 'system';
  static String mode = 'mode';
  static String login = 'login';
  static String token = 'token';
  static String welcome = 'welcome';

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

  ///

  static List<Category> categoryList = [];
  static String categoryListPreference = 'categoryList';

  static Future setCategory({required String id, required String name}) async {
    categoryList.add(Category(name: name, id: id));
    await getStorage.write(
      categoryListPreference,
      categoryList.cast<Category>(),
    );
  }

  static List<Category> getCategory() {
    return getStorage.read(categoryListPreference) ?? [];
  }
}
