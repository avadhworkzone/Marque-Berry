import 'package:socialv/model/apiModel/responseModel/meme_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class MemeCategoryRepo extends BaseService {
  Future<MemeCategoryResModel> memeCategory() async {
    Map<String, dynamic> body = {};
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      body: body,
      url: '$baseURL$memeCategoriesURL',
    );
    return MemeCategoryResModel.fromJson(response);
  }
}
