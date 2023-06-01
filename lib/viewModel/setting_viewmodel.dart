import 'package:get/get.dart';
import 'package:socialv/main.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/get_notification_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';

class SettingViewModel extends GetxController {
  @override
  void onInit() {
    _isNotification =
        PreferenceUtils.getNotificationBool(key: PreferenceUtils.notification);
    super.onInit();
  }

  String isThemeTap = PreferenceUtils.getString(
            key: PreferenceUtils.mode,
          ) ==
          ""
      ? "light"
      : PreferenceUtils.getString(
          key: PreferenceUtils.mode,
        );

  void themeTap() async {
    isThemeTap = isThemeTap == "dark" ? "light" : "dark";
    await PreferenceUtils.setInt(
      key: PreferenceUtils.system,
      value: 1,
    );
    await PreferenceUtils.setString(
      key: PreferenceUtils.mode,
      value: isThemeTap == "light" ? "dark" : "light",
    );
    isLightTheme.add(isThemeTap == "light" ? true : false);
    update();
  }

  bool _isNotification = false;

  bool get isNotification => _isNotification;

  set isNotification(bool value) {
    _isNotification = value;

    PreferenceUtils.setBool(
      key: PreferenceUtils.notification,
      value: _isNotification,
    );
    update();
  }

  /// ==========================  API CALL START  ==========================
  ApiResponse setNotificationStatusApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== CHANGE NOTIFICATION STATUS ================================
  Future<void> changeNotificationStatus() async {
    logs('loading..');
    setNotificationStatusApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetNotificationListRepo().changeNotificationStatusRepo();
      setNotificationStatusApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('setNotificationStatusApiResponse ERROR :=> $e');
      setNotificationStatusApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
