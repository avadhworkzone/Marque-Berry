import 'package:socialv/model/apiModel/responseModel/upload_template_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

import '../apiModel/requestModel/upload_template_req_model.dart';

class UploadTemplateRepo extends BaseService {
  Future<UploadTemplateResModel> uploadTemplate(
    UploadTemplateReqModel reqModel,
  ) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$uploadTemplateURL',
      uploadTemplateData: true,
    );

    return UploadTemplateResModel.fromJson(response);
  }
}
