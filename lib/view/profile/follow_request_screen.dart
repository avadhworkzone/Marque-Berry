import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/pending_request_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

import '../../commanWidget/custom_btn.dart';
import '../../model/apiModel/requestModel/delete_follow_request_req_model.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/decoration_utils.dart';
import '../../viewModel/category_view_model.dart';
import '../../viewModel/profile_view_model.dart';

class FollowRequestScreen extends StatelessWidget {
  FollowRequestScreen({
    Key? key,
  }) : super(key: key);

  final viewModel = Get.find<FollowFollowingViewModel>();
  final ProfileViewModel profileViewModel = Get.find<ProfileViewModel>();
  final CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? bgColor = Theme.of(context).colorScheme.background;
    Color? boxBgColor = Theme.of(context).scaffoldBackgroundColor;
    Color? iconColor = Theme.of(context).primaryTextTheme.caption!.color;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: bgColor,
      backgroundColor: Theme.of(context).cardColor,
      appBar: customAppbar(
        context: context,
        title: 'Follow request',
        icon: const Icon(
          Icons.search_rounded,
          color: ColorUtils.black2E,
        ),
      ),
      body: GetBuilder<FollowFollowingViewModel>(initState: (state) {
        viewModel.getPendingRequestList();
      }, builder: (con) {
        if (con.getPendingRequestApiResponse.status == Status.LOADING ||
            con.getPendingRequestApiResponse.status == Status.INITIAL) {
          return Center(child: Loader());
        } else if (con.getPendingRequestApiResponse.status == Status.ERROR) {
          return Center(child: SomethingWentWrong());
        }

        PendingRequestResModel pendingRequestResModel =
            con.getPendingRequestApiResponse.data;
        if (pendingRequestResModel.status != 200) {
          return Center(
            child: AdoroText(VariableUtils.noDataFound),
          );
        }
        final pendingData = pendingRequestResModel.data ?? [];
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: boxBgColor,
                  ),
                  height: size.height / 1.1 - 39,
                  width: size.width,
                  child: pendingData.isEmpty
                      ? Center(
                          child: AdoroText(VariableUtils.noDataFound),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AdoroText(
                                    'Follow request (${pendingData.length})',
                                    color: blackWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  // AdoroText(
                                  //   'SEE All',
                                  //   color: ColorUtils.black92,
                                  // )
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: ListView.builder(
                                    itemCount: pendingData.length,
                                    itemBuilder: (context, index) {
                                      final user = pendingData[index];
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              user.fullName ?? 'N/A',
                                              style: TextStyle(
                                                color: blackWhite,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '@ ${user.username}',
                                              style: TextStyle(
                                                  color: ColorUtils.black92),
                                            ),
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.w),
                                              child: Container(
                                                color: Colors.grey[200],
                                                child: OctoImage(
                                                  fit: BoxFit.cover,
                                                  width: 13.w,
                                                  height: 13.w,
                                                  image: NetworkImage(
                                                      user.image ?? ""),
                                                  progressIndicatorBuilder:
                                                      (context, progress) {
                                                    double? value;
                                                    var expectedBytes = progress
                                                        ?.expectedTotalBytes;
                                                    if (progress != null &&
                                                        expectedBytes != null) {
                                                      value = progress
                                                              .cumulativeBytesLoaded /
                                                          expectedBytes;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: value,
                                                        color: blackWhite,
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (context, error,
                                                          stacktrace) =>
                                                      Padding(
                                                    padding:
                                                        EdgeInsets.all(2.w),
                                                    child: CommonImage(
                                                      img: IconsWidgets
                                                          .userImages,
                                                      color: ColorUtils.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    profileViewModel.isLoading =
                                                        true;
                                                    await viewModel
                                                        .acceptFollowRequest(
                                                            user.id.toString());
                                                    if (viewModel
                                                            .acceptFollowRequestApiResponse
                                                            .status ==
                                                        Status.COMPLETE) {
                                                      // await profileViewModel
                                                      //     .getProfileDetail(user
                                                      //         .id
                                                      //         .toString());
                                                      viewModel
                                                          .getPendingRequestList();
                                                    }
                                                    profileViewModel.isLoading =
                                                        false;
                                                  },
                                                  child: Image.asset(
                                                    ImagesWidgets
                                                        .tickSquareImage,
                                                    scale: 4,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.sp,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    profileViewModel.isLoading =
                                                        true;
                                                    await viewModel
                                                        .deleteFollowRequest(
                                                            DeleteFollowReqModel(
                                                                id: user.id
                                                                    .toString(),
                                                                flag:
                                                                    'delete'));
                                                    if (viewModel
                                                            .deleteFollowRequestApiResponse
                                                            .status ==
                                                        Status.COMPLETE) {
                                                      categoryFeedViewModel
                                                          .setFollowData(
                                                              user.id!, false);
                                                      // await profileViewModel
                                                      //     .getProfileDetail(user
                                                      //         .id
                                                      //         .toString());

                                                      viewModel
                                                          .getPendingRequestList();
                                                    }
                                                    profileViewModel.isLoading =
                                                        false;
                                                  },
                                                  child: Image.asset(
                                                    ImagesWidgets
                                                        .closeSquareImage,
                                                    scale: 4,
                                                    color: iconColor,
                                                  ),
                                                ),
                                                // InkWell(
                                                //   onTap: () {},
                                                //   child: Image.asset(
                                                //     ImagesWidgets
                                                //         .tickSquareImage,
                                                //     scale: 4,
                                                //   ),
                                                // ),
                                                // SizedBox(
                                                //   width: 5.sp,
                                                // ),
                                                // InkWell(
                                                //   onTap: () {},
                                                //   child: Image.asset(
                                                //     ImagesWidgets
                                                //         .closeSquareImage,
                                                //     scale: 4,
                                                //     color: iconColor,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const Divider()
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
