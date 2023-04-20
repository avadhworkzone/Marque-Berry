import 'package:socialv/model/apiModel/requestModel/apply_now_campaign_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/apply_now_campaign_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/browser_template_res.dart';
import 'package:socialv/model/apiModel/responseModel/upload_template_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

import '../apiModel/requestModel/upload_template_req_model.dart';

class BrowserTemplateRepo extends BaseService {
  Future<BrowserTemplateResModel> browserTemplate() async {
    Map<String, dynamic> body = {};

    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      body: body,
      url: '$baseURL$listTemplatesURL',
    );

    return BrowserTemplateResModel.fromJson(response);
  }
}
