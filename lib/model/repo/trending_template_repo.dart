import 'package:socialv/model/apiModel/responseModel/trending_template_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class TrendingTemplateRepo extends BaseService {
  Future<TrendingTemplateResModel> trendingTemplate() async {
    Map<String, dynamic> body = {};

    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      body: body,
      url: '$baseURL$getTrendingTemplatesURL',
    );

    return TrendingTemplateResModel.fromJson(response);
  }
}
