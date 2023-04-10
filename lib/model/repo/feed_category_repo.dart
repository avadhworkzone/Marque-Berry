import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/enum_utils.dart';

class FeedCategoryRepo extends BaseService {
  Future<List<CategoryResModel>> feedCategory({
    required String category,
    required String pageNumber,
  }) async {
    Map<String, dynamic> body = {};

    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      body: body,
      url: '$baseURL$feedCategoryURL$category&pageNumber=$pageNumber',
    );

    logs('RES ---->${response.runtimeType}');
    return (response as List).map((e) => CategoryResModel.fromJson(e)).toList();
  }
}
