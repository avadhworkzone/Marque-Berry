import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/appService/dynamic_link.dart';
import 'package:socialv/appService/notification_service.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/custom_btn.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/get_following_list_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/notification_chating_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/message/chatting.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

sharePostBottomSheet({
  required int postIdArg,
  required CategoryFeedViewModel categoryFeedViewModel,
}) {
  FollowFollowingViewModel followRequestViewModel =
      Get.find<FollowFollowingViewModel>();
  followRequestViewModel
      .getFollowingList((PreferenceUtils.getInt(key: 'userid')).toString());
  String searchUserStr = "";
  List<FollowingData> selectedUser = [];
  bool isLoading = false;

  Get.bottomSheet(Builder(builder: (context) {
    print(
        'MediaQuery.of(context).viewInsets.bottom=>${MediaQuery.of(context).viewInsets.bottom}');
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    return Container(
      decoration: boxDecoration(),
      height: MediaQuery.of(context).viewInsets.bottom == 0
          ? 80.h
          : Get.height - MediaQuery.of(context).viewInsets.bottom - 70,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
      child: GetBuilder<FollowFollowingViewModel>(
          builder: (followFollowingViewModel) {
        if (followRequestViewModel.getFollowingListApiResponse.status ==
                Status.LOADING ||
            followRequestViewModel.getFollowingListApiResponse.status ==
                Status.INITIAL) {
          return Center(child: Loader());
        } else if (followRequestViewModel.getFollowingListApiResponse.status ==
            Status.ERROR) {
          return Center(child: SomethingWentWrong());
        }
        final GetFollowingListResModel getFollowingListResModel =
            followRequestViewModel.getFollowingListApiResponse.data;
        if (getFollowingListResModel.status.toString() ==
            VariableUtils.status500) {
          return Center(
            child: AdoroText(
              getFollowingListResModel.msg ?? VariableUtils.somethingWentWrong,
            ),
          );
        }
        List<FollowingData> users = getFollowingListResModel.data ?? [];
        return StatefulBuilder(builder: (context, setState) {
          if (searchUserStr.isNotEmpty) {
            users = (getFollowingListResModel.data ?? [])
                .where((element) =>
                    (element.fullName ?? '')
                        .toLowerCase()
                        .contains(searchUserStr.toLowerCase()) ||
                    (element.username ?? '')
                        .toLowerCase()
                        .contains(searchUserStr.toLowerCase()))
                .toList();
          } else {
            users = getFollowingListResModel.data ?? [];
          }
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: TextField(
                  cursorColor: ColorUtils.black,
                  onChanged: (value) {
                    searchUserStr = value;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      fillColor: ColorUtils.white,
                      filled: true,
                      hintText: 'Search..',
                      // suffixIcon: Icon(Icons.search,color: whiteBlack2E,),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White!),
                          borderRadius: BorderRadius.circular(10.sp)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White),
                          borderRadius: BorderRadius.circular(10.sp)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White),
                          borderRadius: BorderRadius.circular(10.sp)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: black92White),
                          borderRadius: BorderRadius.circular(10.sp))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: users.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return GestureDetector(
                      onTap: () {
                        final containIndex = selectedUser
                            .indexWhere((element) => element.id == user.id);
                        if (containIndex > -1) {
                          selectedUser.removeAt(containIndex);
                        } else {
                          selectedUser.add(user);
                        }
                        setState(() {});
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              ProfileImg(image: user.image ?? ""),
                              if (selectedUser.indexWhere(
                                      (element) => element.id == user.id) >
                                  -1)
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                        radius: 9.sp,
                                        backgroundColor: ColorUtils.blueB9,
                                        child: Icon(
                                          Icons.check,
                                          size: 13.sp,
                                        ))),
                            ],
                          ),
                          SizeConfig.sH1,
                          AdoroText(user.username ?? user.fullName ?? 'N/A')
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (isLoading)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CupertinoActivityIndicator(),
                ),
              if (selectedUser.isNotEmpty && !isLoading)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomBtn(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final postLink =
                            '${DynamicLink.uriPrefix}/post?postId=$postIdArg';
                        for (var user in selectedUser) {
                          bool exists = (await FirebaseCollection.chatCollection
                                  .doc(chatId(
                                      PreferenceUtils.getInt(key: 'userid')
                                          .toString(),
                                      user.id.toString()))
                                  .get())
                              .exists;
                          if (exists == false) {
                            await FirebaseCollection.chatCollection
                                .doc(chatId(
                                    PreferenceUtils.getInt(key: 'userid')
                                        .toString(),
                                    user.id.toString()))
                                .set({"message": {}});
                          }

                          await FirebaseCollection.chatCollection
                              .doc(chatId(
                                  PreferenceUtils.getInt(key: 'userid')
                                      .toString(),
                                  user.id.toString()))
                              .update(
                            {
                              "message": FieldValue.arrayUnion([
                                {
                                  'date': DateTime.now(),
                                  "message": postLink,
                                  'senderId':
                                      PreferenceUtils.getInt(key: 'userid')
                                          .toString(),
                                  'receiverId': user.id.toString(),
                                  "seen": false,
                                  "document": chatId(
                                      PreferenceUtils.getInt(key: 'userid')
                                          .toString(),
                                      user.id.toString()),
                                  "messageType": MessageType.TEXT.name,
                                }
                              ]),
                              "last_message_time":
                                  DateTime.now().millisecondsSinceEpoch,
                              'senderId': PreferenceUtils.getInt(key: 'userid')
                                  .toString(),
                              'receiverId': user.id.toString(),
                            },
                          ).then((value) {
                            /// UPDATE SENDER DATA IN FIREBASE
                            FirebaseCollection.userCollection
                                .doc(PreferenceUtils.getInt(key: 'userid')
                                    .toString())
                                .set({
                              'id': PreferenceUtils.getInt(
                                      key: PreferenceUtils.userid)
                                  .toString(),
                              'name': PreferenceUtils.getString(
                                      key: PreferenceUtils.fullname)
                                  .toString(),
                              'userName': PreferenceUtils.getString(
                                      key: PreferenceUtils.username)
                                  .toString(),
                              'userImage': PreferenceUtils.getString(
                                      key: PreferenceUtils.profileImage)
                                  .toString(),
                              'deviceToken': PreferenceUtils.getString(
                                      key: PreferenceUtils.deviceToken)
                                  .toString(),
                              'updatedTime':
                                  DateTime.now().millisecondsSinceEpoch,
                            });

                            /// UPDATE RECEIVER DATA IN FIREBASE
                            FirebaseCollection.userCollection
                                .doc(user.id.toString())
                                .set({
                              'id': user.id.toString(),
                              'name': user.fullName.toString(),
                              'userName': user.username.toString(),
                              'userImage': user.image.toString(),
                              'deviceToken': user.deviceToken,
                              'updatedTime':
                                  DateTime.now().millisecondsSinceEpoch,
                            });
                            final messageData = NotificationChattingModel(
                              receiverFcmToken: PreferenceUtils.getString(
                                      key: PreferenceUtils.deviceToken)
                                  .toString(),
                              receiverId: PreferenceUtils.getInt(
                                      key: PreferenceUtils.userid)
                                  .toString(),
                              receiverImage: PreferenceUtils.getString(
                                      key: PreferenceUtils.profileImage)
                                  .toString(),
                              receiverName: PreferenceUtils.getString(
                                      key: PreferenceUtils.fullname)
                                  .toString(),
                              receiverUserName: PreferenceUtils.getString(
                                      key: PreferenceUtils.username)
                                  .toString(),
                              senderId: user.id.toString(),
                              senderImage: user.image.toString(),
                              senderName: user.fullName.toString(),
                              senderUserName: user.username.toString(),
                            );

                            NotificationService.sendMessage(
                                receivedToken: user.deviceToken!,
                                msg: "Post",
                                title: user.username ?? "N/A",
                                data: {
                                  'data': messageData.toJson(),
                                  'id': DateTime.now().millisecond.toString(),
                                  'notification_type':
                                      NotificationType.Chatting.name
                                });
                          });
                        }
                        Get.back();
                      },
                      text: VariableUtils.send),
                )
            ],
          );
        });
      }),
    );
  }), isScrollControlled: true);
}

class ProfileImg extends StatelessWidget {
  const ProfileImg({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.w),
      child: Container(
        height: 20.w,
        width: 20.w,
        color: ColorUtils.greyFA,
        child: OctoImage(
          fit: BoxFit.cover,
          height: 20.w,
          width: 20.w,
          image: NetworkImage(image),
          progressIndicatorBuilder: (context, progress) {
            double? value;
            var expectedBytes = progress?.expectedTotalBytes;
            if (progress != null && expectedBytes != null) {
              value = progress.cumulativeBytesLoaded / expectedBytes;
            }
            return Center(
              child: CircularProgressIndicator(
                value: value,
                color: blackWhite,
              ),
            );
          },
          errorBuilder: (context, error, stacktrace) => Container(
            height: 20.w,
            width: 20.w,
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
    );
  }
}

BoxDecoration boxDecoration() {
  return BoxDecoration(
    color: ColorUtils.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5.w),
      topRight: Radius.circular(5.w),
    ),
  );
}
