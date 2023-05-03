import 'dart:io';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/view/profile/edit_profile.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/viewModel/profile_view_model.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/profile/following_screen.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/utils/app_services/common_profile_image.dart';
import 'package:socialv/model/apiModel/responseModel/get_user_res_model.dart';
import 'package:socialv/model/apiModel/requestModel/update_cover_pic_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/update_cover_pic_res_model.dart';

class ImagesModel {
  final String image;

  ImagesModel({required this.image});
}

class ProfileScreen1 extends StatefulWidget {
  ProfileScreen1({Key? key}) : super(key: key);

  @override
  State<ProfileScreen1> createState() => _ProfileScreen1State();
}

class _ProfileScreen1State extends State<ProfileScreen1> {
  final List<ImagesModel> imagesList = [
    ImagesModel(
      image:
          'https://thumbs.dreamstime.com/b/environment-earth-…male-hand-holding-tree-nature-field-118143566.jpg',
    ),
    ImagesModel(
      image:
          'https://thumbs.dreamstime.com/b/panoramic-landscap…flowers-nature-backg-park-background-91174058.jpg',
    ),
    ImagesModel(
      image:
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
    ),
    ImagesModel(
      image:
          'https://thumbs.dreamstime.com/b/panoramic-landscap…flowers-nature-backg-park-background-91174058.jpg',
    ),
    ImagesModel(
      image:
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
    ),
    ImagesModel(
      image:
          'https://thumbs.dreamstime.com/b/environment-earth-…male-hand-holding-tree-nature-field-118143566.jpg',
    ),
    ImagesModel(
      image:
          'https://thumbs.dreamstime.com/b/environment-earth-…male-hand-holding-tree-nature-field-118143566.jpg',
    ),
    ImagesModel(
        image:
            'https://thumbs.dreamstime.com/b/panoramic-landscap…flowers-nature-backg-park-background-91174058.jpg'),
    ImagesModel(
      image:
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
    ),
  ];

  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();

  ProfileController profileController = Get.find<ProfileController>();

  UpdateCoverPicReqModel updateCoverPicReqModel = UpdateCoverPicReqModel();

  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;

    return WillPopScope(
      onWillPop: () async {
        bottomBarController.pageChange(0);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: greyFABlack32,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(15.w),
          child: CommonAppBar(
            color: ColorUtils.transparent,
            title: 'Profile',
            onTap: () {
              bottomBarController.pageChange(0);
            },
          ),
        ),
        body: GetBuilder<ProfileController>(
          initState: (_) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              profileController.clearCoverImage();
            });
          },
          builder: (profileController) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizeConfig.sH1,
                  Stack(
                    children: [
                      Container(
                        height: 40.w,
                        width: Get.width,
                        margin: EdgeInsets.only(bottom: 9.w),
                        child: profileController.coverImagePath != ""
                            ? Image.file(
                                File(profileController.coverImagePath),
                                fit: BoxFit.fill,
                              )
                            : CommonCoverImage(),
                      ),
                      Positioned(
                        right: 2.w,
                        top: 2.w,
                        child: InkWell(
                          onTap: () async {
                            await profileController.pickCoverImage(context);
                          },
                          highlightColor: ColorUtils.transparent,
                          splashColor: ColorUtils.transparent,
                          child: Container(
                            width: 8.w,
                            height: 8.w,
                            child: Icon(
                              Icons.edit,
                              size: 4.w,
                              color: ColorUtils.white,
                            ),
                            decoration: DecorationUtils.doneDecoration(context),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 37.5.w,
                        child: CommonProfileImage(heightWidth: 25.w),
                      ),
                    ],
                  ),
                  SizeConfig.sH1,
                  AdoroText(
                    "${PreferenceUtils.getString(key: PreferenceUtils.username)}",
                    textAlign: TextAlign.center,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: blackWhite,
                  ),
                  SizeConfig.sH2,
                  Container(
                    height: 22.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 28.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizeConfig.sH05,
                                AdoroText('Posts', color: black92White),
                                SizeConfig.sH05,
                                AdoroText(
                                  '86',
                                  fontSize: 15.sp,
                                  color: blackWhite,
                                  fontWeight: FontWeightClass.fontWeightBold,
                                ),
                                SizeConfig.sH05,
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => FollowerFollowing(
                                followingCounter: 1,
                                title: 'Followers',
                              ),
                            );
                          },
                          child: Container(
                            width: 28.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizeConfig.sH05,
                                AdoroText('Followers', color: black92White),
                                SizeConfig.sH05,
                                AdoroText(
                                  '86',
                                  fontSize: 16.sp,
                                  color: blackWhite,
                                  fontWeight: FontWeightClass.fontWeightBold,
                                ),
                                SizeConfig.sH05,
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => FollowerFollowing(
                                followingCounter: 0,
                                title: 'Following',
                              ),
                            );
                          },
                          child: Container(
                            width: 28.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizeConfig.sH05,
                                AdoroText('Following', color: black92White),
                                SizeConfig.sH05,
                                AdoroText(
                                  '86',
                                  color: blackWhite,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeightClass.fontWeightBold,
                                ),
                                SizeConfig.sH05,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizeConfig.sH2,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => EditProfile());
                      },
                      child: Container(
                        height: 15.w,
                        width: Get.width,
                        color: whiteBlack2E,
                        child: Center(
                          child: AdoroText(
                            'Edit Profile',
                            color: black92White,
                            fontWeight: FontWeightClass.fontWeight600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizeConfig.sH3,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 3.w,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        color: whiteBlack2E,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.5.w,
                          vertical: 3.5.w,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 12.w,
                              width: 90.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => profileController.changeTab(0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Container(
                                            width: 40.w,
                                            child: Center(
                                              child: AdoroText(
                                                "All posts",
                                                color: profileController
                                                            .tabIndex ==
                                                        0
                                                    ? ColorUtils.blueB9
                                                    : black92White,
                                                fontWeight: FontWeightClass
                                                    .fontWeight700,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 0.5.w,
                                            width: 40.w,
                                            color:
                                                profileController.tabIndex == 0
                                                    ? ColorUtils.blueB9
                                                    : ColorUtils.black92
                                                        .withOpacity(0.2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => profileController.changeTab(1),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Container(
                                            width: 40.w,
                                            child: Center(
                                              child: AdoroText(
                                                "Mentions",
                                                fontWeight: FontWeightClass
                                                    .fontWeight700,
                                                color: profileController
                                                            .tabIndex ==
                                                        1
                                                    ? ColorUtils.blueB9
                                                    : black92White,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 0.5.w,
                                            width: 40.w,
                                            color:
                                                profileController.tabIndex == 1
                                                    ? ColorUtils.blueB9
                                                    : ColorUtils.black92
                                                        .withOpacity(0.2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizeConfig.sH2,
                            profileController.tabIndex == 1
                                ? Center(
                                    child: AdoroText(
                                      "No mentions",
                                      color: black92White,
                                    ),
                                  )
                                : Container(
                                    width: 90.w,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: imagesList.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 3.2.w,
                                        crossAxisSpacing: 3.2.w,
                                      ),
                                      itemBuilder: (c, i) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1.5.w),
                                          child: Image.network(
                                            imagesList[i].image,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Container(
                  //   height: 150.w,
                  //   width: 100.w,
                  //   child: Column(
                  //     children: [
                  //       TabBar(
                  //         controller: _tabController,
                  //         tabs: [
                  //           Tab(
                  //             child: AdoroText('All Post',
                  //                 color: ColorUtils.black92),
                  //           ),
                  //           Tab(
                  //             child: AdoroText('Mentions',
                  //                 color: ColorUtils.black92),
                  //           ),
                  //         ],
                  //       ),
                  //       TabBarView(
                  //         controller: _tabController,
                  //         children: [
                  //           const Center(
                  //               child: const Text('Content of Tab One')),
                  //           const Center(
                  //               child: const Text('Content of Tab Two'))
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProfileController extends GetxController {
  int tabIndex = 0;

  changeTab(value) {
    tabIndex = value;
    update();
  }

  String coverImagePath = "";

  clearCoverImage() {
    coverImagePath = "";
    update();
  }

  CropImage cropImageClass = CropImage();

  Future<String> pickCoverImage(context) async {
    coverImagePath = "";
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        PlatformFile file = result.files.first;

        final cropPath = await cropImageClass.cropImage(
          context: context,
          image: File(file.path!),
          isBackGround: true,
        );
        coverImagePath = cropPath?.path ?? "";

        if (coverImagePath != "") {
          await updateCoverImage(cropPath);
        }
      }
    } catch (e) {
      logs("NORMAL IMAGE CATCH $e");
    }
    update();
    return coverImagePath;
  }

  ProfileViewModel profileViewModel = Get.find<ProfileViewModel>();
  UpdateCoverPicReqModel updateCoverPicReqModel = UpdateCoverPicReqModel();

  updateCoverImage(cropPath) async {
    updateCoverPicReqModel.coverPhoto = cropPath;

    await profileViewModel.updateUserCoverPic(updateCoverPicReqModel);
    if (profileViewModel.updateUserCoverPicApiResponse.status ==
        Status.COMPLETE) {
      final UpdateCoverPicResModel updateCoverPicResModel =
          profileViewModel.updateUserCoverPicApiResponse.data;

      if (updateCoverPicResModel.status == VariableUtils.status200) {
        getUserProfile();
        showSnackBar(
          message: updateCoverPicResModel.message ??
              VariableUtils.somethingWentWrong,
          snackbarSuccess: true,
        );
      } else {
        showSnackBar(
          message: updateCoverPicResModel.message ??
              VariableUtils.somethingWentWrong,
        );
      }
    }
  }

  void getUserProfile() async {
    await profileViewModel.getUserProfile();
    if (profileViewModel.getUserProfileApiResponse.status == Status.COMPLETE) {
      final GetUserResDetail response =
          profileViewModel.getUserProfileApiResponse.data;

      var profileData = response.data?[0];

      PreferenceUtils.setString(
          key: PreferenceUtils.username, value: profileData?.username ?? "");

      PreferenceUtils.setString(
          key: PreferenceUtils.fullname, value: profileData?.fullName ?? "");

      PreferenceUtils.setString(
        key: PreferenceUtils.profileImage,
        value: profileData?.image ?? "",
      );

      PreferenceUtils.setString(
        key: PreferenceUtils.coverImage,
        value: profileData?.coverPhoto ?? "",
      );
    }
  }
}
