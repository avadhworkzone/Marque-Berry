import 'package:socialv/model/apiModel/responseModel/get_following_list_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class GetFollowingListRepo extends BaseService {
  Future<GetFollowingListResModel> getFollowingList(String userId) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$getFollowingListURL$userId',
    );

    return GetFollowingListResModel.fromJson(response);
  }
}
