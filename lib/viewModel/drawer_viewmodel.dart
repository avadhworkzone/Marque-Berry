import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/suppor_req_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/get_note_repo.dart';
import 'package:socialv/model/repo/get_notification_repo.dart';
import 'package:socialv/model/repo/support_repo.dart';
import 'package:socialv/utils/const_utils.dart';

class DrawerVideModel extends GetxController {
  ApiResponse getNoteApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse postSupportApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getNotificationListApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== GET NOTE VIEW MODEL ================================
  Future<void> getNote() async {
    logs('loading..');
    getNoteApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetNoteRepo().getNote();
      getNoteApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getNoteApiResponse ERROR :=> $e');
      getNoteApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET NOTE VIEW MODEL ================================
  Future<void> support(SupportReqModel reqModel) async {
    logs('loading..');
    postSupportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await SupportRepo().supportRepo(reqModel);
      postSupportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('postSupportApiResponse ERROR :=> $e');
      postSupportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET NOTIFICATION LIST ================================
  Future<void> getNotificationList() async {
    logs('loading..');
    getNotificationListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetNotificationListRepo().getNotificationRepo();
      getNotificationListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getNotificationListApiResponse ERROR :=> $e');
      getNotificationListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
