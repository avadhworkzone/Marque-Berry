import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

import '../apiModel/requestModel/update_profile_pic_req_model.dart';
import '../apiModel/responseModel/update_profile_pic_res_model.dart';

class UpdateUserProfilePicRepo extends BaseService {
  Future<UpdateProfilePicResModel> updateUserProfilePic(
      UpdateProfilePicReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$uploadProfilePicURL',
      fileUpload: true,
    );
    return UpdateProfilePicResModel.fromJson(response);
  }
}
