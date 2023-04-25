import 'package:socialv/model/apiModel/responseModel/update_cover_pic_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

import '../apiModel/requestModel/update_cover_pic_req_model.dart';

class UpdateUserCoverPicRepo extends BaseService {
  Future<UpdateCoverPicResModel> updateUserCoverPic(
      UpdateCoverPicReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$uploadCoverPhotoURL',
      fileUpload: true,
    );
    return UpdateCoverPicResModel.fromJson(response);
  }
}
