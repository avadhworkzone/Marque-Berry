import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/model/apiModel/responseModel/result_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/view/drawer/view_result.dart';

import '../../commanWidget/common_appbar.dart';
import '../../commanWidget/common_image.dart';
import '../../commanWidget/loader.dart';
import '../../utils/adoro_text.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/variable_utils.dart';
import '../../viewModel/drawer_viewmodel.dart';

class Result extends StatefulWidget {
  Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final DrawerVideModel getResult = Get.find<DrawerVideModel>();

  @override
  void initState() {
    getResult.getResult();
    print("============${getResult}");

    super.initState();
    tabController = TabController(
      vsync: this,
      initialIndex: 0,
      length: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;

    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: PreferredSize(
          preferredSize: Size(100.w, 60),
          child: CommonAppBar(
            color: ColorUtils.transparent,
            title: VariableUtils.resultText,
            onTap: () => Get.back(),
          ),
        ),
        body: GetBuilder<DrawerVideModel>(
          builder: (controller) {
            if (controller.getResultApiResponse.status == Status.LOADING ||
                controller.getResultApiResponse.status == Status.INITIAL) {
              return Center(child: Loader());
            } else if (controller.getResultApiResponse.status == Status.ERROR) {
              return Center(child: SomethingWentWrong());
            }
            final ResultResModel resultResModel =
                controller.getResultApiResponse.data;

            if (resultResModel.status != 200) {
              return Center(
                child: AdoroText(VariableUtils.noDataFound),
              );
            }

            final campaignsList = resultResModel.data?.campaigns;
            final contestsList = resultResModel.data?.contests;

            return Column(
              children: [
                TabBar(controller: tabController, tabs: [
                  Tab(
                    child: Text(
                      'Campaign',
                      style: TextStyle(
                        color: black92White,
                        fontWeight: FontWeightClass.fontWeight600,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Contest',
                      style: TextStyle(
                        color: black92White,
                        fontWeight: FontWeightClass.fontWeight600,
                      ),
                    ),
                  ),
                ]),
                Expanded(
                    child: TabBarView(
                  controller: tabController,
                  children: [
                    CampaignList(
                      campaignsList: campaignsList,
                    ),
                    ContestList(
                      contestsList: contestsList,
                    ),
                  ],
                )),
              ],
            );
          },
        ));
  }
}

class CampaignList extends StatelessWidget {
  CampaignList({
    super.key,
    required this.campaignsList,
  });

  final List<Campaigns>? campaignsList;

  final DrawerVideModel drawerVideModel = Get.find<DrawerVideModel>();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    return ListView.builder(
      itemCount: campaignsList!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              SizeConfig.sH1,
              Container(
                height: 9.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: whiteBlack2E,
                  boxShadow: [
                    BoxShadow(blurRadius: 3, color: ColorUtils.grey.shade200),
                  ],
                  borderRadius: BorderRadius.circular(3.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizeConfig.sW1,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.w),
                      child: Container(
                        color: Colors.grey[200],
                        child: OctoImage(
                          fit: BoxFit.cover,
                          width: 12.w,
                          height: 12.w,
                          image: NetworkImage(
                            campaignsList![index].logo ?? "",
                          ),
                          progressIndicatorBuilder: (context, progress) {
                            double? value;
                            var expectedBytes = progress?.expectedTotalBytes;
                            if (progress != null && expectedBytes != null) {
                              value = progress.cumulativeBytesLoaded /
                                  expectedBytes;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: value,
                                color: blackWhite,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stacktrace) => Padding(
                            padding: EdgeInsets.all(2.w),
                            child: CommonImage(
                              img: IconsWidgets.userImages,
                              color: ColorUtils.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizeConfig.sW5,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizeConfig.sH1,
                          AdoroText(
                            campaignsList![index].brandName ?? "",
                            fontSize: 11.sp,
                            fontWeight: FontWeightClass.fontWeightBold,
                            color: blackWhite,
                          ),
                          AdoroText(
                            campaignsList![index].campaignName ?? "",
                            fontSize: 11.sp,
                            fontWeight: FontWeightClass.fontWeightBold,
                            color: ColorUtils.black92,
                          ),
                        ],
                      ),
                    ),
                    SizeConfig.sW13,
                    InkWell(
                      onTap: () {
                        drawerVideModel.getResultDetail(
                            campaignsList![index].id.toString(), "campaign");
                        Get.to(ViewResult(
                          resultType: "campaign",
                        ));
                      },
                      // onTap: (
                      //
                      //     )
                      // => Get.to(ViewResult()),
                      child: Container(
                        height: 4.h,
                        width: 24.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorUtils.linearGradient7,
                              ColorUtils.linearGradient4,
                              ColorUtils.linearGradient5,
                              ColorUtils.linearGradient8,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.w),
                          ),
                        ),
                        child: Center(
                          child: AdoroText(
                            VariableUtils.viewResult,
                            color: ColorUtils.white,
                            fontWeight: FontWeightClass.fontWeight600,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ContestList extends StatelessWidget {
  ContestList({
    super.key,
    required this.contestsList,
  });

  List<Contests>? contestsList;
  final DrawerVideModel drawerVideModel = Get.find<DrawerVideModel>();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    return ListView.builder(
      itemCount: contestsList!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              SizeConfig.sH1,
              Container(
                height: 9.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: whiteBlack2E,
                  boxShadow: [
                    BoxShadow(blurRadius: 3, color: ColorUtils.grey.shade200),
                  ],
                  borderRadius: BorderRadius.circular(3.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Row(
                  children: [
                    SizeConfig.sW2,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.w),
                      child: Container(
                        color: Colors.grey[200],
                        child: OctoImage(
                          fit: BoxFit.cover,
                          width: 12.w,
                          height: 12.w,
                          image: NetworkImage(
                            contestsList![index].image ?? "",
                          ),
                          progressIndicatorBuilder: (context, progress) {
                            double? value;
                            var expectedBytes = progress?.expectedTotalBytes;
                            if (progress != null && expectedBytes != null) {
                              value = progress.cumulativeBytesLoaded /
                                  expectedBytes;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: value,
                                color: blackWhite,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stacktrace) => Padding(
                            padding: EdgeInsets.all(2.w),
                            child: CommonImage(
                              img: IconsWidgets.userImages,
                              color: ColorUtils.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // CircleAvatar(
                    //   child: ImagesWidgets.userImage,
                    // ),
                    SizeConfig.sW2,
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5.w, left: 4.w),
                        child: AdoroText(
                          contestsList![index].status ?? "",
                          // VariableUtils.contestName,
                          fontSize: 12.sp,
                          fontWeight: FontWeightClass.fontWeightBold,
                          color: blackWhite,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        drawerVideModel.getResultDetail(
                            contestsList![index].id.toString(), "contest");
                        Get.to(ViewResult(
                          resultType: 'contest',
                        ));
                      },
                      // onTap: () => Get.to(ViewResult()),
                      child: Container(
                        height: 4.h,
                        width: 24.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorUtils.linearGradient7,
                              ColorUtils.linearGradient4,
                              ColorUtils.linearGradient5,
                              ColorUtils.linearGradient8,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.w),
                          ),
                        ),
                        child: Center(
                          child: AdoroText(
                            VariableUtils.viewResult,
                            color: ColorUtils.white,
                            fontWeight: FontWeightClass.fontWeight600,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
