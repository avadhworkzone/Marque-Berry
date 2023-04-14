import 'dart:io';
import 'dart:typed_data';
import 'package:better_player/better_player.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/view/sharePost/tag_a_people.dart';
import 'package:socialv/viewModel/create_post_view_model.dart';
import 'package:socialv/model/apiModel/requestModel/create_post_req_model.dart';

import '../../model/apiModel/responseModel/create_post_res_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/size_config_utils.dart';

class SharePost extends StatefulWidget {
  SharePost({Key? key}) : super(key: key);

  @override
  State<SharePost> createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> with TickerProviderStateMixin {
  String dropdownName = '';
  String dropdownvalue = '';

  final description = TextEditingController();
  SharePostController sharePostController = Get.find<SharePostController>();

  final bottomBarController = Get.find<BottomBarController>();
  CreatePostReqModel createPostReqModel = CreatePostReqModel();
  CreatePostViewModel createPostViewModel = Get.find<CreatePostViewModel>();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    bool isSending = false;
    String _selectedFile = '';
    return GetBuilder<CreatePostViewModel>(builder: (createPostViewModel) {
      return GetBuilder<SharePostController>(builder: (sharePostController) {
        return Material(
          color: whiteBlack2E,
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeConfig.sH1,
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                bottomBarController.pageChange(0);
                              },
                              splashRadius: 6.w,
                              icon: Icon(
                                Icons.close,
                                size: 8.w,
                                color: blackWhite,
                              ),
                            ),
                            AdoroText(
                              VariableUtils.sharePost,
                              fontSize: 15.sp,
                              fontWeight: FontWeightClass.fontWeightBold,
                              color: blackWhite,
                            ),
                            SizeConfig.sW18,
                            Container(
                              height: 5.h,
                              width: 30.w,
                              decoration:
                                  DecorationUtils.welcomeDecoration(context),
                              child: TextButton(
                                onPressed: () {
                                  createPostApi(
                                    createPostReqModel,
                                    sharePostController,
                                  );
                                },
                                child: Text(
                                  VariableUtils.Post,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeightClass.fontWeightBold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizeConfig.sH3,
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.w),
                              child: Container(
                                height: 20.w,
                                width: 20.w,
                                child: Image.asset("assets/images/profile.png"),
                              ),
                            ),
                            SizeConfig.sW4,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AdoroText(
                                  "${PreferenceUtils.getString(key: PreferenceUtils.username)}",
                                  color: blackWhite,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeightClass.fontWeightBold,
                                ),
                                SizeConfig.sH1,
                                Container(
                                  height: 4.h,
                                  // width: 35.w,
                                  decoration: BoxDecoration(
                                    color: ColorUtils.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.w),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizeConfig.sW2,
                                      Icon(
                                        Icons.add_box_outlined,
                                        color: ColorUtils.black,
                                      ),
                                      SizeConfig.sW2,
                                      DropdownButton(
                                        hint: Text(
                                          dropdownName == ""
                                              ? "Category"
                                              : dropdownName,
                                          style: TextStyle(
                                            color: ColorUtils.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: ColorUtils.black,
                                        ),
                                        items: categoryDataList.map((items) {
                                          return DropdownMenuItem(
                                            value: items.name,
                                            child: AdoroText(
                                              items.name ?? "",
                                              color: blackWhite,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          var index =
                                              categoryDataList.firstWhere(
                                            (element) =>
                                                element.name == newValue,
                                          );
                                          setState(() {
                                            dropdownName =
                                                index.name.toString();
                                            dropdownvalue = index.id.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizeConfig.sH5,
                        AdoroText(
                          VariableUtils.whatYouWantToTalkAbout,
                          color: blackWhite,
                          fontSize: 13.sp,
                          fontWeight: FontWeightClass.fontWeight600,
                        ),
                        SizeConfig.sH2,

                        CommonTextFormField(
                          color: blackWhite,
                          validator: () {},
                          controller: description,
                          allowInputFormatters:
                              RegularExpression.alphabetDigitsPattern,
                          denyInputFormatters:
                              RegularExpression.onlyFirstSpaceNoAllowPattern,
                        ),
                        SizeConfig.sH2,
                        if (sharePostController.sourcePath != "")
                          Container(
                            height: 50.w,
                            width: Get.width,
                            color: ColorUtils.note,
                            child: Stack(
                              children: [
                                if (sharePostController.sourceName == "image")
                                  Center(
                                    child: Image.file(
                                      File(sharePostController.sourcePath
                                          .toString()),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                if (sharePostController.sourceName == "video")
                                  Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: AspectRatio(
                                      aspectRatio: 18 / 10,
                                      child: BetterPlayer.file(
                                        sharePostController.sourcePath
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                if (sharePostController.sourceName == "gif")
                                  GifView.memory(
                                    _selectedFile.toString() as Uint8List,
                                    height: 200,
                                    width: 200,
                                  ),
                                // if (sharePostController.sourceName == "template")
                                //   Text("DOCX"),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    splashRadius: 6.w,
                                    onPressed: () {
                                      sharePostController.clearSourcePath();
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(height: 55.w),
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     FilePickerResult? result =
                        //         await FilePicker.platform.pickFiles(
                        //       type: FileType.custom,
                        //       allowedExtensions: ['gif'],
                        //     );
                        //     if (result != null) {
                        //       PlatformFile selectedFile = result.files.first;
                        //       setState(() {
                        //         _selectedFile =
                        //             File(result.files.first) as String;
                        //       });
                        //     }
                        //   },
                        //   child: Text('Select GIF'),
                        // ),

                        SizeConfig.sH2,
                        // CommonTextFieldContainer(
                        //   controller: description,
                        //   color: ColorUtils.note,
                        //   suffixIcon: Padding(
                        //     padding: EdgeInsets.only(
                        //       bottom: 35.w,
                        //     ),
                        //     child: IconButton(
                        //       onPressed: () {},
                        //       splashRadius: 6.w,
                        //       icon: Icon(
                        //         Icons.close,
                        //         size: 3.h,
                        //         color: Theme.of(context).textTheme.titleSmall?.color,
                        //       ),
                        //     ),
                        //   ),
                        //   prefixIcon: Padding(
                        //     padding: EdgeInsets.only(top: 40.w, right: 5.w),
                        //     child: Icon(
                        //       Icons.person_add_alt_sharp,
                        //       color: ColorUtils.black92,
                        //     ),
                        //   ),
                        // ),
                        UploadPhoto(sharePostController: sharePostController),
                        SizeConfig.sH3,
                      ],
                    ),
                  ),
                ),
                if (createPostViewModel.createPostApiResponse.status ==
                    Status.LOADING)
                  Center(child: Loader())
              ],
            ),
          ),
        );
      });
    });
  }

  createPostApi(CreatePostReqModel createPostReqModel,
      SharePostController sharePostController) async {
    if (dropdownvalue == "") {
      showSnackBar(
        message: "Category not selected",
        snackbarSuccess: false,
      );
    } else if (description.text == "") {
      showSnackBar(
        message: "Description is required",
        snackbarSuccess: false,
      );
    } else if (sharePostController.sourcePath == "") {
      showSnackBar(
        message: "Image not selected",
        snackbarSuccess: false,
      );
    } else {
      createPostReqModel.content = description.text;
      createPostReqModel.categoryId = int.parse(dropdownvalue);
      createPostReqModel.contentUrl = sharePostController.sourcePath;
      createPostReqModel.contentType = sharePostController.sourceName;

      await createPostViewModel.createPost(createPostReqModel);
      if (createPostViewModel.createPostApiResponse.status == Status.LOADING ||
          createPostViewModel.createPostApiResponse.status == Status.INITIAL) {
      } else if (createPostViewModel.createPostApiResponse.status ==
          Status.COMPLETE) {
        final CreatePostResModel createPostResModel =
            createPostViewModel.createPostApiResponse.data;

        bottomBarController.pageChange(0);

        showSnackBar(
          message: createPostResModel.msg ?? "Post added successfully",
          snackbarSuccess: true,
        );
      } else if (createPostViewModel.createPostApiResponse.status ==
          Status.ERROR) {
        bottomBarController.pageChange(0);
        showSnackBar(
          message: VariableUtils.somethingWentWrong,
        );
      }
    }
  }
}

class UploadPhoto extends StatelessWidget {
  SharePostController sharePostController;

  UploadPhoto({Key? key, required this.sharePostController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    return Column(
      children: [
        Divider(color: blackWhite, thickness: 1),
        commonUploadTile(
          title: VariableUtils.uploadAPhoto,
          sharePostController: sharePostController,
          uploadType: "image",
          icon: 'assets/icons/image.png',
        ),
        Divider(color: blackWhite, thickness: 1),
        commonUploadTile(
          sharePostController: sharePostController,
          uploadType: "video",
          icon: 'assets/icons/video.png',
          title: VariableUtils.uploadAVideo,
        ),
        Divider(color: blackWhite, thickness: 1),
        commonUploadTile(
          sharePostController: sharePostController,
          uploadType: 'gif',
          icon: 'assets/icons/gif.png',
          title: VariableUtils.uploadAGIF,
        ),
        Divider(color: blackWhite, thickness: 1),
        commonUploadTile(
          sharePostController: sharePostController,
          uploadType: 'template',
          icon: 'assets/icons/choose.png',
          title: VariableUtils.chooseATemplate,
        ),
        Divider(color: blackWhite, thickness: 1),
        commonUploadTile(
          sharePostController: sharePostController,
          uploadType: 'tag',
          icon: 'assets/icons/tag.png',
          title: VariableUtils.tagAFriend,
        ),
      ],
    );
  }
}

class commonUploadTile extends StatelessWidget {
  final String uploadType;
  final SharePostController sharePostController;
  final String icon;
  final String title;

  commonUploadTile({
    super.key,
    required this.sharePostController,
    required this.uploadType,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    return InkWell(
      splashColor: ColorUtils.transparent,
      highlightColor: ColorUtils.transparent,
      onTap: () {
        if (uploadType == "tag") {
          Get.to(() => TagAPeople());
        } else {
          sharePostController.pickFile("uploadType");
        }
      },
      child: Row(
        children: [
          CommonImageScale(img: icon, color: blackWhite, scale: 1.2.w),
          SizeConfig.sW2,
          AdoroText(
            title,
            fontSize: 11.sp,
            color: black92White,
            fontWeight: FontWeightClass.fontWeight600,
          ),
        ],
      ),
    );
  }
}

class SharePostController extends GetxController {
  String sourcePath = "";
  String sourceName = "";

  pickFile(String extension) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: extension == "image"
            ? ['jpg', 'jpeg', 'png']
            : extension == "video"
                ? ['mp4', 'mov', 'wmv', 'avi', 'mpg', '3gp', 'mkv']
                : extension == "gif"
                    ? ['gif']
                    : ['pdf', 'doc', 'docx', 'xlsx', 'xltx'],
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        sourcePath = file.path!;
      } else {
        sourcePath = "";
      }
      sourceName = extension;
      update();
    } catch (e) {
      sourceName = "";
      showSnackBar(message: "Permission is required.");
      logs("message:=====> $e");
    }
  }

  clearSourcePath() {
    sourcePath = "";
    update();
  }
}
