import 'package:socialv/model/apiModel/responseModel/user_profile_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/responseModel/get_user_res_model.dart';

/// =================  GET USER DETAIL =================== ///
class GetUserProfileRepo extends BaseService {
  Future<GetUserResDetail> getUserProfile(int userId) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$getUserDetails$userId',
    );

    return GetUserResDetail.fromJson(response);
  }
}

/// =================  GET PROFILE DETAIL =================== ///
class GetProfileDetailRepo extends BaseService {
  Future<UserProfileResModel> getProfileDetail(String userId) async {

    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$getProfileDetails$userId',
    );

    return UserProfileResModel.fromJson(response);
  }
}
