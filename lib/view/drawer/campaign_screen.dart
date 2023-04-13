import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/model/apiModel/requestModel/apply_now_campaign_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/apply_now_contest_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/compaign_contest_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/viewModel/campaign_contest_view_model.dart';

import '../../model/apiModel/responseModel/apply_now_contest_res_model.dart';
import 'details_screen.dart';

class CampaignScreen extends StatefulWidget {
  CampaignScreen({Key? key}) : super(key: key);

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  @override
  void initState() {
    campaignContestApiCall();
    super.initState();
  }

  CampaignContestViewModel campaignContestViewModel =
      Get.find<CampaignContestViewModel>();

  campaignContestApiCall() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await campaignContestViewModel.getCampaignContest();
    });
  }

  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();

  @override
  Widget build(BuildContext context) {
    Color? whiteBlue = Theme.of(context).scaffoldBackgroundColor;
    Color? whiteBlack = Theme.of(context).textTheme.titleSmall?.color;
    return GetBuilder<CampaignContestViewModel>(
      builder: (campaignContestViewModel) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: ColorUtils.grey[100], //whiteBlue,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: whiteBlue,
              leading: IconButton(
                splashRadius: 6.w,
                onPressed: () {
                  bottomBarController.pageChange(0);
                },
                icon: Icon(Icons.arrow_back, color: whiteBlack),
              ),
              title: const TabBar(
                // labelColor: ColorUtils.blueB9,
                // unselectedLabelColor: ColorUtils.black92,
                tabs: [
                  Tab(
                    child: AdoroText(
                      'Campaign',
                      fontWeight: FontWeightClass.fontWeight600,
                    ),
                  ),
                  Tab(
                    child: AdoroText(
                      'Contest',
                      fontWeight: FontWeightClass.fontWeight600,
                    ),
                  ),
                ],
              ),
              actions: [SizeConfig.sW9],
            ),
            body: TabBarView(
              children: [
                CampaignScn(campaignContestViewModel: campaignContestViewModel),
                ContestScreen(
                  campaignContestViewModel: campaignContestViewModel,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

///Campaign Screen
class CampaignScn extends StatelessWidget {
  CampaignContestViewModel campaignContestViewModel;

  CampaignScn({Key? key, required this.campaignContestViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (campaignContestViewModel.getCampaignContestApiResponse.status ==
            Status.LOADING ||
        campaignContestViewModel.getCampaignContestApiResponse.data == null) {
      return Center(child: Loader());
    } else if (campaignContestViewModel.getCampaignContestApiResponse.status ==
        Status.ERROR) {
      return Center(child: SomethingWentWrong());
    }
    final CampaignContestResModel campaignContestResponse =
        campaignContestViewModel.getCampaignContestApiResponse.data;

    if (campaignContestResponse.campaign?.length == 0) {
      return Center(child: Text('No campaign available'));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: campaignContestResponse.campaign?.length ?? 0,
      itemBuilder: (context, index) {
        final dataIndex = campaignContestResponse.campaign![index];
        return TabBarMethod(
          campaignContestViewModel: campaignContestViewModel,
          method: 'campaign',
          size: size,
          title: dataIndex.firstAward ?? "",
          createOn: dataIndex.createdOn ?? "",
          applied: dataIndex.applied ?? "false",
          image: dataIndex.image ?? "",
          description: dataIndex.description ?? "",
          campaignContestId: dataIndex.id.toString() ?? "",
        );
      },
    );
  }
}

///Contest Screen
class ContestScreen extends StatelessWidget {
  CampaignContestViewModel campaignContestViewModel;
  ContestScreen({
    Key? key,
    required this.campaignContestViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (campaignContestViewModel.getCampaignContestApiResponse.status ==
        Status.LOADING) {
      return Center(child: Loader());
    } else if (campaignContestViewModel.getCampaignContestApiResponse.status ==
        Status.ERROR) {
      return Center(child: SomethingWentWrong());
    }
    final CampaignContestResModel contestContestResponse =
        campaignContestViewModel.getCampaignContestApiResponse.data;

    if (contestContestResponse.contest?.length == 0) {
      return Center(child: Text('No contest available'));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contestContestResponse.contest?.length ?? 0,
      itemBuilder: (context, index) {
        final dataIndex = contestContestResponse.contest?[index];
        logs(dataIndex?.firstAward ?? "");

        return TabBarMethod(
          method: 'contest',
          size: size,
          createOn: dataIndex?.createdOn ?? "",
          applied: dataIndex?.applied ?? "false",
          title: dataIndex?.firstAward ?? '',
          image: dataIndex?.image ?? '',
          description: dataIndex?.description ?? "",
          campaignContestId: dataIndex?.id.toString() ?? "",
          campaignContestViewModel: campaignContestViewModel,
        );
      },
    );
  }
}

class TabBarMethod extends StatelessWidget {
  Size size;
  String title;
  String image;
  String method;
  String description;
  String createOn;
  String applied;

  String campaignContestId;

  CampaignContestViewModel campaignContestViewModel;

  TabBarMethod({
    Key? key,
    required this.size,
    required this.title,
    required this.method,
    required this.description,
    required this.image,
    required this.applied,
    required this.createOn,
    required this.campaignContestId,
    required this.campaignContestViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignScreenController>(
      builder: (campaignScreenController) {
        return Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.w),
          child: Container(
            margin: EdgeInsets.only(bottom: 2.w),
            width: size.width,
            decoration: BoxDecoration(
              color: ColorUtils.white,
              borderRadius: BorderRadius.circular(5.w),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
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
                              value = progress.cumulativeBytesLoaded /
                                  expectedBytes;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: value,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.color,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stacktrace) =>
                              Container(
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
                      title,
                      fontSize: 12.sp,
                      color: ColorUtils.black,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: AdoroText(
                      'Time Left : ${postTimeCalculate(createOn, "")}',
                      color: ColorUtils.black92,
                    ),
                  ),
                  SizeConfig.sH1,
                  AdoroText(
                    '$description',
                    maxLines: 4,
                    color: ColorUtils.black92,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizeConfig.sH1,
                  InkWell(
                    onTap: () {
                      if (method == "contest") {
                        campaignScreenController.applyContest(
                          applied: applied,
                          campaignId: campaignContestId,
                          campaignContestViewModel: campaignContestViewModel,
                        );
                      } else if (method == "campaign") {
                        campaignScreenController.applyCampaign(
                          applied: applied,
                          contestId: campaignContestId,
                          campaignContestViewModel: campaignContestViewModel,
                        );
                      }
                    },
                    child: Container(
                      height: 5.h,
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
                              borderRadius: BorderRadius.circular(3.w),
                            )
                          : BoxDecoration(color: Colors.grey[100]),
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
                  SizeConfig.sH1,
                  InkWell(
                    onTap: () => Get.to(
                      () => DetailsScreen(
                        method: method,
                        applied: applied,
                        image: image,
                        time: 'Time Left : ${postTimeCalculate(createOn, "")}',
                        description: description,
                        campaignId: campaignContestId,
                        title: title,
                        campaignContestViewModel: campaignContestViewModel,
                      ),
                    ),
                    child: Container(
                      height: 40,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.all(
                          Radius.circular(3.w),
                        ),
                      ),
                      child: Center(
                        child: AdoroText(
                          'KNOW MORE',
                          color: ColorUtils.black92,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  SizeConfig.sH2,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CampaignScreenController extends GetxController {
  Future<String> pickCampaignImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        PlatformFile file = result.files.first;
        return file.path!;
      } else
        return '';
    } catch (e) {
      return '';
    }
  }

  ApplyContestReqModel applyContestReqModel = ApplyContestReqModel();
  ApplyCampaignReqModel applyCampaignReqModel = ApplyCampaignReqModel();

  applyContest({
    required String applied,
    // required CampaignScreenController campaignScreenController,
    required CampaignContestViewModel campaignContestViewModel,
    required String campaignId,
  }) async {
    if (applied == "false") {
      String path = await pickCampaignImage();
      logs(path);

      if (path != '') {
        applyContestReqModel.media = path;
        applyContestReqModel.campaignId = campaignId;
        await campaignContestViewModel.applyContest(applyContestReqModel);

        if (campaignContestViewModel.applyContestApiResponse.status ==
            Status.COMPLETE) {
          final ApplyContestResModel response =
              campaignContestViewModel.applyContestApiResponse.data;
          showSnackBar(
            message: response.msg ?? "apply successfully",
            snackbarSuccess: true,
          );
        }
      } else {
        showSnackBar(message: "Image not selected");
      }
    } else if (applied == "true") {
      showSnackBar(message: "Already applied");
    }
  }

  applyCampaign({
    required String applied,
    required CampaignContestViewModel campaignContestViewModel,
    required String contestId,
  }) async {
    if (applied == "false") {
      String path = await pickCampaignImage();
      if (path != '') {
        applyCampaignReqModel.media = path;
        applyCampaignReqModel.contestId = contestId;

        await campaignContestViewModel.applyCampaign(applyCampaignReqModel);

        if (campaignContestViewModel.applyCampaignApiResponse.status ==
            Status.COMPLETE) {
          final CampaignContestResModel response =
              campaignContestViewModel.applyCampaignApiResponse.data;
          showSnackBar(
            message: response.msg ?? "apply successfully",
            snackbarSuccess: true,
          );
        }
      } else {
        showSnackBar(message: "Image not selected");
      }
    } else if (applied == "true") {
      showSnackBar(message: "Already applied");
    }
  }
}
