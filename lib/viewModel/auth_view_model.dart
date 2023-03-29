import 'package:get/get.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/driver_post_repo.dart';
import 'package:socialv/model/apiModel/requestModel/driver_post_req_model.dart';

class AuthViewModel extends GetxController {
  ApiResponse driverPostApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== DRIVER POST VIEW MODEL ================================

  Future<void> driverPost(DriverPostReqModel reqModel) async {
    logs('loading..');
    driverPostApiResponse = ApiResponse.loading('LOADING');
    // update();
    try {
      final response = await DriverPostRepo().driverPost(reqModel);
      driverPostApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('driverPostApiResponse ERROR :=> $e');
      driverPostApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
