import '../../utils/enum_utils.dart';
import '../apiModel/responseModel/post_comment_res_model.dart';
import '../apiService/api_service.dart';
import '../apiService/base_service.dart';

class WithdrawnAmountOtpValidateRepo extends BaseService {
  Future<PostCommentResModel> withdrawnAmountOtpValidateRepo(
      String otp, String amount) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: {"otp": otp, "amount": amount},
      url: '$baseURL$withdrawalAmountOtpValidate',
    );
    return PostCommentResModel.fromJson(response);
  }
}
