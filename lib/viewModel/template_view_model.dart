import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/get_campaign_id_req_model.dart';
import 'package:socialv/model/repo/apply_campaign_repo.dart';
import 'package:socialv/model/repo/apply_contest_repo.dart';
import 'package:socialv/model/repo/browser_template_repo.dart';
import 'package:socialv/model/repo/campaign_contest_repo.dart';
import 'package:socialv/model/repo/my_template_repo.dart';
import 'package:socialv/model/repo/trending_template_repo.dart';
import 'package:socialv/model/repo/upload_template_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import '../model/apiModel/requestModel/apply_now_campaign_req_model.dart';
import '../model/apiModel/requestModel/apply_now_contest_req_model.dart';
import '../model/apiModel/requestModel/upload_template_req_model.dart';
import '../model/repo/get_campaign_id_repo.dart';

class TemplateViewModel extends GetxController {
  ApiResponse myTemplateApiResponse = ApiResponse.initial('INITIAL');

  ApiResponse browserTemplateApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse trendingTemplateApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse uploadTemplateApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== GET CAMPAIGN CONTEST VIEW MODEL ================================

  Future<void> myTemplate() async {
    logs('loading..');
    myTemplateApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await MyTemplateRepo().myTemplate();
      myTemplateApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('myTemplateApiResponse ERROR :=> $e');
      myTemplateApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== BROWSER VIEW MODEL ================================

  Future<void> browserTemplate() async {
    logs('loading..');
    browserTemplateApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await BrowserTemplateRepo().browserTemplate();
      browserTemplateApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('browserTemplateApiResponse ERROR :=> $e');
      browserTemplateApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== Trending template VIEW MODEL ================================

  Future<void> trendingTemplate() async {
    logs('loading..');
    trendingTemplateApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await TrendingTemplateRepo().trendingTemplate();
      trendingTemplateApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('trendingTemplateApiResponse ERROR :=> $e');
      trendingTemplateApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== Upload template VIEW MODEL ================================

  Future<void> uploadTemplate(UploadTemplateReqModel reqModel) async {
    logs('loading..');
    uploadTemplateApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await UploadTemplateRepo().uploadTemplate(reqModel);
      uploadTemplateApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('uploadTemplateApiResponse ERROR :=> $e');
      uploadTemplateApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
