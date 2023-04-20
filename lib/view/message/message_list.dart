import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/get_follower_list_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/message/chatting.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

import '../../commanWidget/common_image.dart';
import '../../utils/assets/images_utils.dart';

class MessageList extends StatelessWidget {
  MessageList({Key? key}) : super(key: key);

  FollowRequestViewModel followRequestViewModel =
      Get.find<FollowRequestViewModel>();

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.w),
        child: CommonAppBar(
          title: 'Messages',
          ontap: () => Get.back(),
        ),
      ),
      body: GetBuilder<FollowRequestViewModel>(
        initState: (_) async {
          await followRequestViewModel.getFollowerList();
        },
        builder: (followRequestViewModel) {
          if (followRequestViewModel.getFollowerListApiResponse.status ==
                  Status.LOADING ||
              followRequestViewModel.getFollowerListApiResponse.status ==
                  Status.INITIAL) {
            return Center(child: Loader());
          } else if (followRequestViewModel.getFollowerListApiResponse.status ==
              Status.ERROR) {
            return Center(child: SomethingWentWrong());
          }
          final GetFollowerListResModel getFollowerListResModel =
              followRequestViewModel.getFollowerListApiResponse.data;
          if (getFollowerListResModel.status.toString() ==
              VariableUtils.status500) {
            return Center(
              child: AdoroText(
                getFollowerListResModel.msg ?? VariableUtils.somethingWentWrong,
              ),
            );
          }
          return ListView.builder(
            itemCount: getFollowerListResModel.data?.length ?? 0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final followData = getFollowerListResModel.data?[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => ChattingScreen(
                          receiverName: followData?.username ?? "",
                          receiverImage: followData?.image ?? "",
                          senderName:
                              PreferenceUtils.getString(key: 'username'),
                          senderId: (PreferenceUtils.getInt(key: 'userid'))
                              .toString(),
                          receiverId: followData?.id.toString() ?? "",
                          senderImage:
                              PreferenceUtils.getString(key: 'profile'),
                        ),
                      );
                    },
                    child: ListTile(
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
                            image: NetworkImage(followData?.image ?? ""),
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
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AdoroText(
                            followData?.username ?? VariableUtils.naError,
                            fontSize: 13.sp,
                            color: blackWhite,
                            fontWeight: FontWeightClass.fontWeight600,
                          ),
                          SizeConfig.sH05,
                        ],
                      ),
                      subtitle: AdoroText(
                        followData?.fullName ?? "",
                        fontSize: 10.sp,
                        color: blackWhite,
                      ),
                      trailing: MessageCount(
                        receiverId: followData?.id.toString() ?? "",
                      ),
                    ),
                  ),
                  Divider(indent: 10, endIndent: 20, color: black92White)
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class MessageCount extends StatelessWidget {
  final String receiverId;
  const MessageCount({Key? key, required this.receiverId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Chat")
          .doc(chatId(
              (PreferenceUtils.getInt(key: 'userid')).toString(), receiverId))
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (!snapshot.data!.exists) {
            return SizedBox();
          }

          final mapData = snapshot.data!.data() as Map<String, dynamic>;
          final count = (mapData["message"] as List<dynamic>)
              .where((element) =>
                  element["seen"] == false &&
                  element["receiverId"] ==
                      (PreferenceUtils.getInt(key: 'userid')).toString())
              .toList()
              .length;
          if (count == 0) {
            return SizedBox();
          }
          return Container(
            padding: EdgeInsets.all(2.w),
            child: AdoroText(
              "$count",
              fontSize: 8.sp,
              color: ColorUtils.white,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorUtils.blueB9,
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}