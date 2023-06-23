import 'package:socialv/model/apiModel/responseModel/update_cover_pic_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class UpdateUserCoverPicRepo extends BaseService {
  Future<UpdateCoverPicResModel> updateUserCoverPic(String coverPhoto) async {
    Map<String, dynamic> body = {'cover_photo': coverPhoto};
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: body,
      url: '$baseURL$uploadCoverPhotoURL',
      fileUpload: true,
    );
    return UpdateCoverPicResModel.fromJson(response);
  }
}
