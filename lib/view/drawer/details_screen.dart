// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/viewModel/campaign_contest_view_model.dart';

import '../../commanWidget/common_appbar.dart';
import '../../commanWidget/common_image.dart';
import '../../utils/assets/images_utils.dart';
import 'campaign_screen.dart';

class DetailsScreen extends StatelessWidget {
  String applied;
  String campaignId;

  String description;
  String time;
  String image;
  String title;
  String method;

  CampaignContestViewModel campaignContestViewModel;

  DetailsScreen({
    Key? key,
    required this.campaignId,
    required this.applied,
    required this.image,
    required this.method,
    required this.time,
    required this.title,
    required this.description,
    required this.campaignContestViewModel,
  }) : super(key: key);

  CampaignScreenController campaignScreenController =
      Get.find<CampaignScreenController>();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: whiteBlack2E,
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.w),
        child: CommonAppBar(title: 'Details', onTap: () => Get.back()),
      ),
      body: GetBuilder<CampaignScreenController>(
          builder: (campaignScreenController) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: whiteBlack2E,
              boxShadow: [
                BoxShadow(blurRadius: 5, color: Colors.grey),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10.w),
                    child: Container(
                      height: 10.w,
                      width: 10.w,
                      color: ColorUtils.greyFA,
                      child: OctoImage(
                        fit: BoxFit.cover,
                        width: 24,
                        height: 24,
                        image: NetworkImage(image),
                        progressIndicatorBuilder: (context, progress) {
                          double? value;
                          var expectedBytes = progress?.expectedTotalBytes;
                          if (progress != null && expectedBytes != null) {
                            value =
                                progress.cumulativeBytesLoaded / expectedBytes;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: value,
                              color:
                                  Theme.of(context).textTheme.titleSmall?.color,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stacktrace) => Container(
                          width: 24,
                          height: 24,
                          color: ColorUtils.grey[200],
                          child: Padding(
                            padding: EdgeInsets.all(1.w),
                            child: CommonImage(
                              img: IconsWidgets.userImages,
                              color: ColorUtils.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: AdoroText(
                    '$title',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: AdoroText(
                    "$time",
                    color: ColorUtils.black92,
                    fontSize: 12.sp,
                  ),
                ),
                SizeConfig.sH1,
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 4.w, right: 4.w, bottom: 4.w),
                    child: AdoroText(
                      description,
                      color: ColorUtils.black92,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (method == "contest") {
                      campaignScreenController.applyContest(
                        applied: applied,
                        campaignId: campaignId,
                        campaignContestViewModel: campaignContestViewModel,
                      );
                    } else if (method == "campaign") {
                      campaignScreenController.applyCampaign(
                        applied: applied,
                        contestId: campaignId,
                        campaignContestViewModel: campaignContestViewModel,
                      );
                    }
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
                    child: Container(
                      height: 6.h,
                      width: size.width,
                      decoration: applied == "false"
                          ? BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorUtils.linearGradient7,
                                  ColorUtils.linearGradient4,
                                  ColorUtils.linearGradient5,
                                  ColorUtils.linearGradient8,
                                ],
                                stops: [
                                  0.0,
                                  0.3,
                                  0.6,
                                  0.9,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(4.w),
                            )
                          : BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                      child: Center(
                        child: AdoroText(
                          applied == "false" ? 'APPLY NOW' : "APPLIED",
                          color: applied == "false"
                              ? ColorUtils.white
                              : ColorUtils.green4E,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
