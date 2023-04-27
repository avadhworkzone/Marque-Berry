import 'package:socialv/model/apiModel/responseModel/my_template_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

import '../apiModel/requestModel/upload_template_req_model.dart';

class MyTemplateRepo extends BaseService {
  Future<MyTemplateResModel> myTemplate() async {
    Map<String, dynamic> body = {};

    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      body: body,
      url: '$baseURL$getMyTemplatesURL',
    );

    return MyTemplateResModel.fromJson(response);
  }
}
