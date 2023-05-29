import 'package:socialv/model/apiModel/responseModel/get_search_users_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/user_profile_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/responseModel/get_user_res_model.dart';

class SearchUsersRepo extends BaseService {
  Future<GetSearchUsersResModel> searchUsersRepo(String searchStr) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$searchUsers$searchStr',
    );

    return GetSearchUsersResModel.fromJson(response);
  }
}
