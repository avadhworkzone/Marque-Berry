import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/view/profile/edit_profile.dart';
import 'package:socialv/view/profile/following_screen.dart';

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

  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

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
            ontap: () {
              bottomBarController.pageChange(0);
            },
          ),
        ),
        body: GetBuilder<ProfileController>(builder: (profileController) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizeConfig.sH2,
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 9.w),
                      child: Image.asset('assets/images/bgProfile.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 36.w,
                      child: CircleAvatar(
                        radius: 12.w,
                        child: Image.asset(
                          'assets/images/profileimages.png',
                        ),
                      ),
                    ),
                  ],
                ),
                // Text(PreferenceUtils.getString(key: "username")),
                // SizeConfig.sH1,
                AdoroText(
                  "${PreferenceUtils.getString(key: "username") ?? ""}",
                  textAlign: TextAlign.center,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: blackWhite,
                ),
                SizeConfig.sH2,
                Container(
                  height: 22.w,
                  padding: EdgeInsets.symmetric(vertical: 3.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Container(
                          width: 28.w,
                          child: Column(
                            children: [
                              AdoroText('Posts', color: black92White),
                              SizeConfig.sH05,
                              AdoroText(
                                '86',
                                fontSize: 15.sp,
                                color: blackWhite,
                                fontWeight: FontWeightClass.fontWeightBold,
                              ),
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
                            children: [
                              AdoroText('Followers', color: black92White),
                              SizeConfig.sH05,
                              AdoroText(
                                '86',
                                fontSize: 16.sp,
                                color: blackWhite,
                                fontWeight: FontWeightClass.fontWeightBold,
                              ),
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
                            children: [
                              AdoroText('following', color: black92White),
                              SizeConfig.sH05,
                              AdoroText(
                                '86',
                                color: blackWhite,
                                fontSize: 15.sp,
                                fontWeight: FontWeightClass.fontWeightBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizeConfig.sH2,
                InkWell(
                  onTap: () {
                    Get.to(() => EditProfile());
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                                              color:
                                                  profileController.tabIndex ==
                                                          0
                                                      ? ColorUtils.blueB9
                                                      : black92White,
                                              fontWeight:
                                                  FontWeightClass.fontWeight700,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          height: 0.5.w,
                                          width: 40.w,
                                          color: profileController.tabIndex == 0
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
                                              fontWeight:
                                                  FontWeightClass.fontWeight700,
                                              color:
                                                  profileController.tabIndex ==
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
                                          color: profileController.tabIndex == 1
                                              ? ColorUtils.blueB9
                                              : black92White,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizeConfig.sH2,
                          Container(
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
                                  borderRadius: BorderRadius.circular(1.5.w),
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
        }),
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
}
