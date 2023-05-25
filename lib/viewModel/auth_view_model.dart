import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/user_category_req_model.dart';
import 'package:socialv/model/repo/get_note_repo.dart';
import 'package:socialv/model/repo/meme_category_repo.dart';
import 'package:socialv/model/repo/user_category_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/repo/login_repo.dart';
import 'package:socialv/model/repo/register_repo.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/validate_otp_repo.dart';
import 'package:socialv/model/apiModel/requestModel/otp_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/login_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/register_req_model.dart';

class AuthViewModel extends GetxController {
  ApiResponse loginApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse registerApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse validateOTPApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse memeCategoryApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse userCategoryApiResponse = ApiResponse.initial('INITIAL');


  /// ======================== LOGIN VIEW MODEL ================================

  Future<void> login(LoginReqModel reqModel) async {
    logs('loading..');
    loginApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await LoginRepo().login(reqModel);
      loginApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('loginApiResponse ERROR :=> $e');
      loginApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== REGISTER VIEW MODEL ================================
  Future<void> register(RegisterReqModel reqModel) async {
    logs('loading..');
    registerApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await RegisterRepo().register(reqModel);
      registerApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('registerApiResponse ERROR :=> $e');
      registerApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== VALIDATE OTP VIEW MODEL ================================
  Future<void> validateOTP(ValidateOTPReqModel reqModel) async {
    logs('loading..');
    validateOTPApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ValidateOTPRepo().validateOTP(reqModel);
      validateOTPApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('validateOTPApiResponse ERROR :=> $e');
      validateOTPApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== MEME CATEGORY VIEW MODEL ================================
  Future<void> memeCategory() async {
    logs('loading..');
    memeCategoryApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await MemeCategoryRepo().memeCategory();
      memeCategoryApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('memeCategoryApiResponse ERROR :=> $e');
      memeCategoryApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== MEME CATEGORY VIEW MODEL ================================
  Future<void> userCategory(UserCategoryReqModel reqModel) async {
    logs('loading..');
    userCategoryApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await UserCategoryRepo().userCategory(reqModel);
      userCategoryApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('userCategoryApiResponse ERROR :=> $e');
      userCategoryApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }


}
