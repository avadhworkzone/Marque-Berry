import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/requestModel/upload_template_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/upload_template_res_model.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/drawer/upload_template.dart';
import 'package:socialv/view/template/my_template.dart';
import 'package:socialv/viewModel/template_view_model.dart';

import '../../commanWidget/noInternet_screen.dart';
import '../../model/apis/api_response.dart';
import '../../utils/assets/images_utils.dart';
import '../../viewModel/connectivity_view_model.dart';
import '../template/browser_template.dart';
import '../template/trending_template.dart';

class TemplateModel {
  final String title;
  final String image;

  TemplateModel({required this.title, required this.image});
}

class Template extends StatelessWidget {
  Template({Key? key}) : super(key: key);

  List<Map<String, dynamic>> template = [
    {"title": 'Browse Template', "image": 'assets/images/browse.png'},
    {"title": 'Trending Template', "image": 'assets/images/trending.png'},
    {"title": 'Upload Template', "image": 'assets/images/upload.png'},
    {"title": 'My Template', "image": 'assets/images/my.png'}
  ];

  ConnectivityViewModel connectivityViewModel =
      Get.find<ConnectivityViewModel>();

  TemplateViewModel templateViewModel = Get.find<TemplateViewModel>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectivityViewModel>(
      init: ConnectivityViewModel(),
      initState: (_) {
        connectivityViewModel.startMonitoring();
      },
      builder: (connectivityViewModel) {
        if (connectivityViewModel.isOnline != null) {
          if (connectivityViewModel.isOnline!) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(16.w),
                child: CommonAppBar(
                  title: VariableUtils.templateText,
                  ontap: () => Get.back(),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14.w,
                    crossAxisSpacing: 14.w,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: ColorUtils.transparent,
                      highlightColor: ColorUtils.transparent,
                      onTap: () {
                        if (index == 0) {
                          Get.to(() => BrowserTemplate());
                        } else if (index == 1) {
                          Get.to(() => TrendingTemplate());
                        } else if (index == 2) {
                          Get.to(() => UploadTemplate());
                        } else if (index == 3) {
                          Get.to(() => MyTemplate());
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 31.w,
                            height: 31.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  ImagesWidgets.circleImage,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(7.w),
                              child: Image.asset(
                                template[index]["image"],
                              ),
                            ),
                          ),
                          SizeConfig.sH1,
                          AdoroText(
                            template[index]["title"],
                            fontWeight: FontWeightClass.fontWeight600,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const NoInterNetConnected();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  TemplateController templateController = Get.find<TemplateController>();
  UploadTemplateReqModel uploadTemplateReqModel = UploadTemplateReqModel();

  uploadTemplate() async {
    String imagePath = await templateController.pickFile();

    if (imagePath != "") {
      uploadTemplateReqModel.template = "standard";
      uploadTemplateReqModel.tag = imagePath;

      await templateViewModel.uploadTemplate(uploadTemplateReqModel);

      if (templateViewModel.uploadTemplateApiResponse.status ==
          Status.COMPLETE) {
        final UploadTemplateResModel response =
            templateViewModel.uploadTemplateApiResponse.data;
        if (response.status.toString() == VariableUtils.status200) {
          logs(response.msg ?? "upload successfully");
        }
        if (response.status.toString() == VariableUtils.status500) {
          logs(response.msg ?? VariableUtils.somethingWentWrong);
        }
      }
    } else {
      showSnackBar(message: "Image not selected");
    }
  }
}

class TemplateController extends GetxController {
  String sourcePath = "";

  Future<String> pickFile() async {
    try {
      sourcePath = "";
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        sourcePath = file.path!;
      } else {
        sourcePath = "";
      }
      update();
      return sourcePath;
    } catch (e) {
      logs("message:=====> $e");
      return "";
    }
  }

  clearSourcePath() {
    sourcePath = "";
    update();
  }
}
