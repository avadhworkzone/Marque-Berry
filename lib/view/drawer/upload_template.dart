import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/model/apiModel/requestModel/upload_template_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/upload_template_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';

import '../../commanWidget/common_appbar.dart';
import '../../commanWidget/custom_btn.dart';

import '../../commanWidget/custom_snackbar.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/variable_utils.dart';
import '../../viewModel/template_view_model.dart';

class UploadTemplate extends StatefulWidget {
  UploadTemplate({Key? key}) : super(key: key);

  @override
  State<UploadTemplate> createState() => _UploadTemplateState();
}

class _UploadTemplateState extends State<UploadTemplate> {
  TemplateViewModel templateViewModel = Get.find<TemplateViewModel>();

  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedTabIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(16.w),
        child: CommonAppBar(
          title: VariableUtils.uploadTemplate,
          onTap: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          SizeConfig.sH3,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UploadBtn(
                height: 5.h,
                width: 30.w,
                onTap: () {
                  setState(() {
                    selectedTabIndex = 0;
                  });
                },
                decoration: selectedTabIndex == 0
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorUtils.linearGradient1,
                            ColorUtils.linearGradient2,
                            ColorUtils.linearGradient3,
                            ColorUtils.linearGradient4,
                            ColorUtils.linearGradient5,
                            ColorUtils.linearGradient6,
                            ColorUtils.linearGradient7,
                          ],
                          stops: [0.0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8],
                        ),
                        borderRadius: BorderRadius.circular(2.w),
                      )
                    : BoxDecoration(),
                text: 'Standard',
                textColor: selectedTabIndex == 0
                    ? ColorUtils.white
                    : ColorUtils.black92,
              ),
              SizeConfig.sW5,
              UploadBtn(
                height: 5.h,
                width: 30.w,
                onTap: () {
                  setState(() {
                    selectedTabIndex = 1;
                  });
                },
                decoration: selectedTabIndex == 0
                    ? BoxDecoration()
                    : BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorUtils.linearGradient1,
                            ColorUtils.linearGradient2,
                            ColorUtils.linearGradient3,
                            ColorUtils.linearGradient4,
                            ColorUtils.linearGradient5,
                            ColorUtils.linearGradient6,
                            ColorUtils.linearGradient7,
                          ],
                          stops: [0.0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8],
                        ),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                text: 'Licensed',
                textColor: selectedTabIndex == 0
                    ? ColorUtils.black92
                    : ColorUtils.white,
              ),
            ],
          ),
          SizeConfig.sH6,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: InkWell(
              onTap: () => selectImage(),
              splashColor: ColorUtils.transparent,
              highlightColor: ColorUtils.transparent,
              child: Container(
                height: 80.w,
                width: 80.w,
                child: selectedImagePath == ""
                    ? Image.asset(
                        '$imagesbasePath/Vector.png',
                        scale: 1.1.w,
                        color: blackWhite,
                      )
                    : Image.file(
                        File(selectedImagePath),
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ),
          SizeConfig.sH10,
          CustomBtn(
            height: 5.h,
            onTap: () {
              if (selectedImagePath != "") {
                uploadTemplateApi(selectedImagePath);
              } else {
                showSnackBar(message: "Image not selected");
              }
            },
            text: 'UPLOAD MEME TEMPLATE',
          ),
        ],
      ),
    );
  }

  String selectedImagePath = "";
  void selectImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        selectedImagePath = file.path!;
      }
      setState(() {});
    } catch (e) {
      selectedImagePath = "";
      showSnackBar(message: "Permission is required.");
    }
  }

  UploadTemplateReqModel uploadTemplateReqModel = UploadTemplateReqModel();

  uploadTemplateApi(imagePath) async {
    uploadTemplateReqModel.template = imagePath;
    uploadTemplateReqModel.tag =
        selectedTabIndex == 0 ? 'standard' : 'licensed';

    await templateViewModel.uploadTemplate(uploadTemplateReqModel);

    if (templateViewModel.uploadTemplateApiResponse.status == Status.COMPLETE) {
      final UploadTemplateResModel uploadTemplateResModel =
          templateViewModel.uploadTemplateApiResponse.data;
      if (uploadTemplateResModel.status == 200) {
        showSnackBar(
          message: uploadTemplateResModel.msg ?? "Upload successfully",
          snackbarSuccess: true,
        );
      }
      if (uploadTemplateResModel.status == 500) {
        showSnackBar(
            message:
                uploadTemplateResModel.msg ?? VariableUtils.somethingWentWrong);
      }
    }
  }
}
