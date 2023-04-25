import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorUtils.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.w),
        child: CommonAppBar(title: 'Details', ontap: () => Get.back()),
      ),
      body: GetBuilder<CampaignScreenController>(
          builder: (campaignScreenController) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: ColorUtils.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
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
                        image: NetworkImage(image ?? ""),
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
                    "${time ?? ""}",
                    color: ColorUtils.black92,
                    fontSize: 12.sp,
                  ),
                ),
                SizeConfig.sH1,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(1.w),
                          child: AdoroText(
                            description ?? "",
                            color: ColorUtils.black92,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
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
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                    child: Container(
                      height: 6.h,
                      width: size.width,
                      decoration: applied == "false"
                          ? BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorUtils.linearGradient1,
                                  ColorUtils.linearGradient6,
                                  ColorUtils.linearGradient7
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.w),
                              ),
                            )
                          : BoxDecoration(
                              color: Colors.grey[100],
                            ),
                      child: Center(
                        child: AdoroText(
                          'APPLY NOW',
                          color: applied == "false"
                              ? ColorUtils.white
                              : ColorUtils.black92,
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
