import 'package:socialv/model/apiModel/responseModel/get_follower_list_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

class GetFollowerListRepo extends BaseService {
  Future<GetFollowerListResModel> getFollowerList() async {
    Map<String, dynamic> body = {};
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      body: body,
      url: '$baseURL$getFollowerListURL',
    );
    return GetFollowerListResModel.fromJson(response);
  }
}
