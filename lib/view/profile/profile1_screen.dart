import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class ImagesModel {
  final String image;

  ImagesModel({required this.image});
}

class ProfileScreen1 extends StatelessWidget {
  ProfileScreen1({Key? key}) : super(key: key);
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

  final isCheck = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bottomBarController.pageChange(0);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(15.w),
          child: CommonAppBar(
            title: 'Profile',
            ontap: () {
              bottomBarController.pageChange(0);
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Image.asset('assets/images/bgProfile.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 50,
                    right: 70,
                    child: CircleAvatar(
                      radius: 40,
                      child: Image.asset(
                        'assets/images/profileimages.png',
                      ),
                    ),
                  ),
                ],
              ),
              SizeConfig.sH2,
              const AdoroText(
                'Ritik Raj',
                // color: ColorUtils.black2E,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              const AdoroText(
                '@ritik_raj1',
                color: ColorUtils.black92,
                fontSize: 15,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: const [
                      AdoroText('Posts', color: ColorUtils.black92),
                      SizedBox(height: 10),
                      AdoroText(
                        '1,286',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      AdoroText('Followers', color: ColorUtils.black92),
                      SizedBox(
                        height: 10,
                      ),
                      AdoroText(
                        '1.2k',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      AdoroText(
                        'Following',
                        color: ColorUtils.black92,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AdoroText('1.1k',
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     InkWell(
              //       onTap: () {},
              //       child: Container(
              //           height: 40,
              //           width: 150,
              //           decoration: BoxDecoration(
              //               gradient: const LinearGradient(
              //                 colors: [
              //                   ColorUtils.linearGradient1,
              //                   ColorUtils.linearGradient6,
              //                   ColorUtils.linearGradient7
              //                 ],
              //                 begin: Alignment.topLeft,
              //                 end: Alignment.bottomRight,
              //               ),
              //               borderRadius: BorderRadius.circular(10)),
              //           child: const Center(
              //             child: AdoroText('Confirm',
              //                 fontSize: 17,
              //                 color: ColorUtils.white,
              //                 fontWeight: FontWeight.bold),
              //           )),
              //     ),
              //     InkWell(
              //       onTap: () {},
              //       child: Container(
              //           height: 40,
              //           width: 130,
              //           decoration: BoxDecoration(
              //               color: ColorUtils.black92,
              //               borderRadius: BorderRadius.circular(10)),
              //           child: const Center(
              //             child: AdoroText('Delete ',
              //                 fontSize: 17,
              //                 color: ColorUtils.white,
              //                 fontWeight: FontWeight.bold),
              //           )),
              //     )
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      const DefaultTabController(
                        length: 2,
                        child: TabBar(
                          tabs: [
                            Tab(
                              child: AdoroText(
                                'All Post',
                                color: ColorUtils.black92,
                              ),
                            ),
                            Tab(
                              child: AdoroText(
                                'Mentions',
                                color: ColorUtils.black92,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                            ),
                            children: imagesList
                                .map((e) => Column(
                                      children: [
                                        SizedBox(
                                          height: 85,
                                          width: 210,
                                          child: Image.network(
                                            e.image,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
