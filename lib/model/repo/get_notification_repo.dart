import 'package:socialv/model/apiModel/responseModel/check_follow_user_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/get_follower_list_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/get_notification_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

class GetNotificationListRepo extends BaseService {
  /// ==========================  GET NOTIFICATION DATA  ==========================
  Future<GetNotificationListResModel> getNotificationRepo() async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$getNotification',
    );
    return GetNotificationListResModel.fromJson(response);
  }

  /// ==========================  CHANGE NOTIFICATION STATUS  ==========================
  Future<CommonStatusMsgResModel> changeNotificationStatusRepo() async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$changeNotificationStatus',
    );
    return CommonStatusMsgResModel.fromJson(response);
  }
}
