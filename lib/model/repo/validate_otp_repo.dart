import 'package:socialv/model/apiModel/requestModel/otp_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/otp_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class ValidateOTPRepo extends BaseService {
  Future<ValidateOTPResModel> validateOTP(ValidateOTPReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$validateOTPURL',
    );
    return ValidateOTPResModel.fromJson(response);
  }
}
