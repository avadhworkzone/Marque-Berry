// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/model/apiModel/responseModel/meme_res_model.dart';
import 'package:socialv/view/home/home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/view/sharePost/tag_a_people.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/template/browser_template.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/viewModel/create_post_view_model.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/view/home/components/video_components.dart';
import 'package:socialv/utils/app_services/common_profile_image.dart';
import 'package:socialv/model/apiModel/requestModel/create_post_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/create_post_res_model.dart';

import '../../utils/adoro_text.dart';
import '../../utils/color_utils.dart';
import '../../utils/variable_utils.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/assets/images_utils.dart';

class SharePost extends StatefulWidget {
  SharePost({Key? key}) : super(key: key);

  @override
  State<SharePost> createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> with TickerProviderStateMixin {
  String categoryId = '';
  String categoryName = '';
  List<Category> categoryDataList = [];

  final description = TextEditingController();
  SharePostController sharePostController = Get.find<SharePostController>();

  final bottomBarController = Get.find<BottomBarController>();
  AuthViewModel authViewModel = Get.find<AuthViewModel>();

  CreatePostReqModel createPostReqModel = CreatePostReqModel();
  CreatePostViewModel createPostViewModel = Get.find<CreatePostViewModel>();

  final HomeController homeController = Get.find<HomeController>();

  final CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  TagAPeopleController tagAPeopleController = Get.find<TagAPeopleController>();

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  void getCategory() {
    print('categoryDataList=>$categoryDataList');
    categoryDataList = selectedCategoryDataList;
    print('selectedCategoryDataList=>$selectedCategoryDataList');
    if (authViewModel.memeCategoryApiResponse.status == Status.COMPLETE) {
      MemeCategoryResModel memeCategoryResModel =
          authViewModel.memeCategoryApiResponse.data;
      if (memeCategoryResModel.status == 200) {
        categoryDataList = memeCategoryResModel.data!
            .map((e) => Category(id: e.id.toString(), name: e.title!))
            .toList();
      }
    }

    logs(
        'categoryDataList======>${categoryDataList.map((e) => jsonEncode(e.toJson())).toList()}');
  }

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        bottomBarController.pageChange(0);
        return Future.value(false);
      },
      child: GetBuilder<TagAPeopleController>(
        builder: (tagAPeopleController) {
          return GetBuilder<SharePostController>(
            builder: (sharePostController) {
              return GetBuilder<CreatePostViewModel>(
                initState: (_) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    sharePostController.clearSourcePath();
                    createPostViewModel.createPostApiResponse =
                        ApiResponse.initial('INITIAL');
                  });
                },
                builder: (createPostViewModel) {
                  return Scaffold(
                    backgroundColor: Theme.of(context).cardColor,
                    bottomSheet: sharePostController.sourcePath == ""
                        ? MediaQuery.of(context).viewInsets.bottom == 0
                            ? UploadPhoto(
                                sharePostController: sharePostController,
                              )
                            : SizedBox()
                        : SizedBox(),
                    body: SafeArea(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizeConfig.sH2,
                                Row(
                                  children: [
                                    SizeConfig.sW4,
                                    InkWell(
                                      splashColor: ColorUtils.transparent,
                                      highlightColor: ColorUtils.transparent,
                                      onTap: () {
                                        Get.back();
                                        bottomBarController.pageChange(0);
                                      },
                                      child: Icon(Icons.close,
                                          size: 6.w, color: blackWhite),
                                    ),
                                    SizeConfig.sW2,
                                    AdoroText(
                                      VariableUtils.sharePost,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeightClass.fontWeight600,
                                      color: blackWhite,
                                    ),
                                    Spacer(),
                                    sharePostController.sourcePath != ""
                                        ? InkWell(
                                            splashColor: ColorUtils.transparent,
                                            highlightColor:
                                                ColorUtils.transparent,
                                            onTap: () {
                                              createPostApi(
                                                createPostReqModel,
                                                sharePostController,
                                              );
                                            },
                                            child: Container(
                                              width: 20.w,
                                              height: 5.h,
                                              child: Image.asset(
                                                ImagesWidgets.submitButtonImage,
                                                // fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Opacity(
                                            opacity: 0.5,
                                            child: Container(
                                              width: 20.w,
                                              height: 27,
                                              decoration: BoxDecoration(
                                                  color: ColorUtils.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                  child: AdoroText(
                                                VariableUtils.Post,
                                                fontSize: 12,
                                                fontWeight: FontWeightClass
                                                    .fontWeight600,
                                                letterSpacing: 0.5,
                                              )),
                                            ),
                                          ),
                                    SizeConfig.sW4,
                                  ],
                                ),
                                SizeConfig.sH3,
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CommonProfileImage(
                                            heightWidth: 18.w,
                                            bgColor: Colors.grey[200],
                                            image: PreferenceUtils.getString(
                                              key: PreferenceUtils.profileImage,
                                            ),
                                          ),
                                          SizeConfig.sW3,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 3.w),
                                                child: AdoroText(
                                                  "${PreferenceUtils.getString(key: PreferenceUtils.username)}",
                                                  color: blackWhite,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeightClass
                                                      .fontWeightBold,
                                                ),
                                              ),
                                              SizeConfig.sH1,
                                              Container(
                                                height: 5.h,
                                                // width: 40.w,
                                                decoration: BoxDecoration(
                                                  color: ColorUtils.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.w),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add_box_outlined,
                                                        color: ColorUtils.black,
                                                      ),
                                                      SizeConfig.sW2,
                                                      DropdownButton(
                                                        underline: SizedBox(),
                                                        menuMaxHeight: 200,
                                                        hint: Text(
                                                          categoryName == ""
                                                              ? "Category"
                                                              : categoryName,
                                                          style: TextStyle(
                                                            color: ColorUtils
                                                                .black,
                                                            fontWeight:
                                                                FontWeightClass
                                                                    .fontWeight600,
                                                          ),
                                                        ),
                                                        icon: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 1.w,
                                                            vertical: 2.w,
                                                          ),
                                                          child: Image(
                                                            image: AssetImage(
                                                              IconsWidgets
                                                                  .dropdownButtonImage,
                                                            ),
                                                            height: 4.h,
                                                            width: 4.w,
                                                          ),
                                                        ),
                                                        items: categoryDataList
                                                            .map((items) {
                                                          return DropdownMenuItem(
                                                            value: items.name,
                                                            child: AdoroText(
                                                              items.name ?? "",
                                                              color: blackWhite,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          var index =
                                                              categoryDataList
                                                                  .firstWhere(
                                                            (element) =>
                                                                element.name ==
                                                                newValue,
                                                          );
                                                          setState(() {
                                                            categoryName = index
                                                                .name
                                                                .toString();

                                                            categoryId = index
                                                                .id
                                                                .toString();
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizeConfig.sH4,
                                      CommonTextFormField(
                                        color: blackWhite,
                                        hintText: VariableUtils
                                            .whatYouWantToTalkAbout,
                                        hintStyle:
                                            TextStyle(color: ColorUtils.grey),
                                        validator: () {},
                                        controller: description,
                                      ),
                                      SizeConfig.sH2,
                                      /*  if (sharePostController.sourcePath !=
                                              "" &&
                                          sharePostController.sourceName ==
                                              "template")
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AdoroText(
                                                sharePostController.sourcePath
                                                    .split("/")
                                                    .last,
                                                color: blackWhite,
                                              ),
                                            ),
                                            IconButton(
                                              splashRadius: 6.w,
                                              onPressed: () {
                                                sharePostController
                                                    .clearSourcePath();
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: blackWhite,
                                              ),
                                            ),
                                          ],
                                        ),*/
                                      if (sharePostController.sourcePath != "")
                                        Container(
                                          // height: 55.w,
                                          width: Get.width,
                                          child: Stack(
                                            children: [
                                              if (sharePostController
                                                      .sourceName ==
                                                  "template")
                                                Container(
                                                  // height: 55.w,
                                                  width: Get.width,
                                                  child: Image.network(
                                                    sharePostController
                                                        .sourcePath,
                                                    fit: BoxFit.contain,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress !=
                                                          null) {
                                                        return SizedBox(
                                                            height: 55.w,
                                                            child:
                                                                CupertinoActivityIndicator());
                                                      }
                                                      return child;
                                                    },
                                                  ),
                                                ),
                                              if (sharePostController
                                                          .sourceName ==
                                                      "image" ||
                                                  sharePostController
                                                          .sourceName ==
                                                      "gif")
                                                Container(
                                                  // height: 55.w,
                                                  width: Get.width,
                                                  child: Image.file(
                                                    File(sharePostController
                                                        .sourcePath),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              if (sharePostController
                                                      .sourceName ==
                                                  "video")
                                                Padding(
                                                  padding: EdgeInsets.all(4.w),
                                                  child: FileVideoPlayer(
                                                    url: sharePostController
                                                        .sourcePath,
                                                    fileVideo: true,
                                                  ),
                                                ),
                                              Positioned(
                                                right: 0,
                                                top: -10,
                                                child: IconButton(
                                                  splashRadius: 2.w,
                                                  onPressed: () {
                                                    sharePostController
                                                        .clearSourcePath();
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: black92White,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 5,
                                                bottom: 5,
                                                child: InkWell(
                                                  highlightColor:
                                                      ColorUtils.transparent,
                                                  splashColor:
                                                      ColorUtils.transparent,
                                                  onTap: () => Get.to(
                                                      () => TagAPeople()),
                                                  child: CommonImageScale(
                                                    img: IconsWidgets.tagImages,
                                                    color: ColorUtils.white,
                                                    scale: 3,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                                SizeConfig.sH2,
                              ],
                            ),
                          ),
                          if (createPostViewModel
                                  .createPostApiResponse.status ==
                              Status.LOADING)
                            Container(
                                color: Colors.black26,
                                width: Get.width,
                                height: Get.height,
                                child: Center(child: Loader()))
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  createPostApi(
    CreatePostReqModel createPostReqModel,
    SharePostController sharePostController,
  ) async {
    var categoryIndex = categoryDataList
        .indexWhere((element) => element.id.toString().contains(categoryId));

    if (categoryId == "") {
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
      createPostReqModel.categoryId = int.parse(categoryId);
      createPostReqModel.contentUrl = sharePostController.sourcePath;
      createPostReqModel.contentType = sharePostController.sourceName;

      if (tagAPeopleController.tagList.isNotEmpty) {
        // createPostReqModel.tag = "(${tagAPeopleController.tagList.join(",")})";
        List<String> tagList =
            tagAPeopleController.tagList.map((e) => e).toList();
        tagList.add(
            PreferenceUtils.getInt(key: PreferenceUtils.userid).toString());
        createPostReqModel.tag = jsonEncode(tagList);
      }
      await createPostViewModel.createPost(createPostReqModel);
      if (createPostViewModel.createPostApiResponse.status == Status.LOADING ||
          createPostViewModel.createPostApiResponse.status == Status.INITIAL) {
      } else if (createPostViewModel.createPostApiResponse.status ==
          Status.COMPLETE) {
        final CreatePostResModel createPostResModel =
            createPostViewModel.createPostApiResponse.data;
        await sharePostController.clearSourcePath();
        tagAPeopleController.clearList();
        description.clear();

        Get.back();
        showSnackBar(
          message: createPostResModel.msg ?? "Post added successfully",
          snackbarSuccess: true,
        );
        homeController.tabChange(categoryIndex + 2);

        homeController.tabNameChange(
          categoryName,
        );
        categoryFeedViewModel.pageNumberIndex = 0;
        homeController.animateTabScroll(28.w * categoryIndex + 2);
        categoryFeedViewModel.isPageLoading = false;
        await categoryFeedViewModel.categoryTrending(categoryName);
      } else if (createPostViewModel.createPostApiResponse.status ==
          Status.ERROR) {
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
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      color: whiteBlack2E,
      padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 5.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: blackWhite, thickness: 1),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: CommonUploadTile(
              title: VariableUtils.uploadAPhoto,
              sharePostController: sharePostController,
              uploadType: "image",
              icon: IconsWidgets.imageImages,
            ),
          ),
          Divider(color: blackWhite, thickness: 1),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: CommonUploadTile(
              sharePostController: sharePostController,
              uploadType: "video",
              icon: IconsWidgets.videoImages,
              title: VariableUtils.uploadAVideo,
            ),
          ),
          Divider(color: blackWhite, thickness: 1),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: CommonUploadTile(
              sharePostController: sharePostController,
              uploadType: 'gif',
              icon: IconsWidgets.gifImages,
              title: VariableUtils.uploadAGIF,
            ),
          ),
          Divider(color: blackWhite, thickness: 1),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: CommonUploadTile(
              sharePostController: sharePostController,
              uploadType: 'template',
              icon: IconsWidgets.chooseImages,
              title: VariableUtils.chooseATemplate,
            ),
          ),
          Divider(color: blackWhite, thickness: 1),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: CommonUploadTile(
              sharePostController: sharePostController,
              uploadType: 'tag',
              icon: IconsWidgets.tagImages,
              title: VariableUtils.tagAFriend,
            ),
          ),
        ],
      ),
    );
  }
}

class CommonUploadTile extends StatelessWidget {
  final String uploadType;
  final SharePostController sharePostController;
  final String icon;
  final String title;

  CommonUploadTile({
    super.key,
    required this.sharePostController,
    required this.uploadType,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;

    return InkWell(
      splashColor: ColorUtils.transparent,
      highlightColor: ColorUtils.transparent,
      onTap: () {
        if (uploadType == "tag") {
          Get.to(() => TagAPeople());
        } else {
          sharePostController.pickFile(extension: uploadType, context: context);
        }
      },
      child: Row(
        children: [
          CommonImageScale(img: icon, color: black92White, scale: 1.2.w),
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

CropImage cropImageClass = CropImage();

class SharePostController extends GetxController {
  String sourcePath = "";
  String sourceName = "";

  pickFile({
    required String extension,
    required BuildContext context,
  }) async {
    try {
      print('extension=>$extension');
      /*  if (extension == "image") {
        final imgFile =
            await ImagePicker.platform.getImage(source: ImageSource.gallery);
        if (imgFile != null) {
          final cropImagePath = await cropImageClass.postCropImage(
            image: File(imgFile.path),
            isBackGround: true,
          );
          sourcePath = cropImagePath?.path ?? '';
        }
      } else if (extension == "gif") {
        final videoFile = await ImagePicker.platform.getVideo(
          source: ImageSource.gallery,
          maxDuration: Duration(seconds: 2),
        );
        if (videoFile != null) {
          print('GIF videoFile.path=>${videoFile.path}');
          sourcePath = videoFile.path;
        }
      } else if (extension == "video") {
        final videoFile = await ImagePicker.platform.getVideo(
          source: ImageSource.gallery,
        );
        if (videoFile != null) {
          print('VIDEO videoFile.path=>${videoFile.path}');
          sourcePath = videoFile.path;
        }
      } else*/

      if (extension == "template") {
        final templateUrl = await Get.to(() => BrowserTemplate(
              isFromCreatePost: true,
            ));
        print('templateUrl==>$templateUrl');
        if (templateUrl != null) {
          sourcePath = templateUrl;
        }
      } else {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: extension == "image"
              ? ['jpg', 'jpeg', 'png']
              : extension == "video"
                  ? ['mp4', 'mov', 'wmv', 'avi', 'mpg', '3gp', 'mkv']
                  : extension == "gif"
                      ? ['gif']
                      : extension == "template"
                          ? ['pdf', 'doc', 'docx', 'xlsx', 'xltx']
                          : [],
        );
        if (result != null) {
          PlatformFile file = result.files.first;

          if (extension == "image") {
            final cropImagePath = await cropImageClass.postCropImage(
              image: File(file.path!),
              isBackGround: true,
            );

            sourcePath = cropImagePath?.path ?? '';
          } else if (extension == "video" || extension == "gif") {
            sourcePath = file.path ?? '';

            logs("sourcePath----->  $sourcePath");
          }
        } else {
          sourcePath = "";
        }
      }

      if (extension == 'gif' &&
          !sourcePath.contains('.gif') &&
          sourcePath.isNotEmpty) {
        showSnackBar(message: "Opps this is not GIF,Please select GIF");
        sourcePath = "";
        update();
        return;
      }
      if (extension == 'image' && sourcePath.isNotEmpty) {
        if (!sourcePath.contains('.jpg') &&
            !sourcePath.contains('.jpeg') &&
            !sourcePath.contains('.png')) {
          showSnackBar(message: "Opps this is not image,Please select image");
          sourcePath = "";
          update();
          return;
        }
      }
      if (extension == 'video' && sourcePath.isNotEmpty) {
        if (!sourcePath.contains('.mp4') &&
            !sourcePath.contains('.mov') &&
            !sourcePath.contains('.wmv') &&
            !sourcePath.contains('.avi') &&
            !sourcePath.contains('.mpg') &&
            !sourcePath.contains('.3gp') &&
            !sourcePath.contains('.mkv')) {
          showSnackBar(message: "Opps this is not video,Please select video");
          sourcePath = "";
          update();
          return;
        }
      }
      sourceName = extension;
      update();
    } catch (e) {
      sourceName = "";
      logs('CATCH:-----> $e');
      showSnackBar(message: "$extension not selected");
    }
  }

  clearSourcePath() {
    sourcePath = "";
    sourceName = "";
    update();
  }
}
