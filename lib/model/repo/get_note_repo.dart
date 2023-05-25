import 'package:socialv/model/apiModel/responseModel/note_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/responseModel/get_all_comment_res_model.dart';

class GetNoteRepo extends BaseService {
  Future<NoteResModel> getNote() async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$noteFromAdoro',
    );
    return NoteResModel.fromJson(response);
  }
}
