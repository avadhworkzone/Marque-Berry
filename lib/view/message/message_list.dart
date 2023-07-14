// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/appService/dynamic_link.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/commanWidget/search_textfield.dart';
import 'package:socialv/model/apiModel/responseModel/firebase_user_model.dart';
import 'package:socialv/model/apiModel/responseModel/get_following_list_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/message/chatting.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

import '../../commanWidget/common_image.dart';
import '../../utils/assets/images_utils.dart';

class MessageList extends StatelessWidget {
  MessageList({Key? key}) : super(key: key);

  FollowFollowingViewModel followRequestViewModel =
      Get.find<FollowFollowingViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size(100.w, 60),
        child: CommonAppBar(
          title: 'Messages',
          onTap: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          SearchTextField(
              verticalPadding: 0,
              onChangedString: (value) {
                followRequestViewModel.searchUserStr = value;
              }),
          Expanded(
            child: GetBuilder<FollowFollowingViewModel>(
              initState: (_) async {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  followRequestViewModel.searchUserStr = "";
                });
                await followRequestViewModel.getFollowingList(
                    (PreferenceUtils.getInt(key: 'userid')).toString());
              },
              builder: (followRequestViewModel) {
                if (followRequestViewModel.getFollowingListApiResponse.status ==
                        Status.LOADING ||
                    followRequestViewModel.getFollowingListApiResponse.status ==
                        Status.INITIAL) {
                  return Center(child: Loader());
                } else if (followRequestViewModel
                        .getFollowingListApiResponse.status ==
                    Status.ERROR) {
                  return Center(child: SomethingWentWrong());
                }
                final GetFollowingListResModel getFollowingListResModel =
                    followRequestViewModel.getFollowingListApiResponse.data;
                // if (getFollowingListResModel.status.toString() ==
                //     VariableUtils.status500) {
                //   return Center(
                //     child: AdoroText(
                //       getFollowingListResModel.msg ??
                //           VariableUtils.somethingWentWrong,
                //     ),
                //   );
                // }

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseCollection.userCollection
                      .orderBy('updatedTime', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    logs(
                        'Foll ==>${getFollowingListResModel.data?.map((e) => jsonEncode(e.toJson())).toList()}');

                    if (!snapshot.hasData) {
                      return Center(child: Loader());
                    }
                    if (snapshot.hasError) {
                      return Center(child: SomethingWentWrong());
                    }
                    List<FirebaseUserModel> firebaseUsers = snapshot.data!.docs
                        .map((e) => FirebaseUserModel.fromJson(
                            e.data() as Map<String, dynamic>))
                        .toList();

                    if (followRequestViewModel.searchUserStr.isNotEmpty) {
                      final searchedList = getFollowingListResModel.data?.where(
                              (element) =>
                                  element.username!.toLowerCase().contains(
                                      followRequestViewModel.searchUserStr) ||
                                  element.fullName!.toLowerCase().contains(
                                      followRequestViewModel.searchUserStr)) ??
                          [];
                      searchedList.forEach((element) {
                        final userContainIndex = firebaseUsers.indexWhere(
                            (user) => user.id == element.id.toString());
                        if (userContainIndex == -1) {
                          firebaseUsers.add(FirebaseUserModel(
                              fullName: element.fullName,
                              deviceToken: element.deviceToken,
                              id: element.id.toString(),
                              userImage: element.image,
                              userName: element.username,
                              updatedTime:
                                  DateTime.now().millisecondsSinceEpoch));
                        }
                      });
                    }

                    if (firebaseUsers.isEmpty) {
                      return Center(
                        child: AdoroText(
                          VariableUtils.userNotFound,
                        ),
                      );
                    }
                    firebaseUsers.removeWhere((element) =>
                        element.id ==
                        PreferenceUtils.getInt(key: PreferenceUtils.userid)
                            .toString());
                    return UserList(
                      users: firebaseUsers,
                      controller: followRequestViewModel,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({Key? key, required this.users, required this.controller})
      : super(key: key);
  final List<FirebaseUserModel> users;
  final FollowFollowingViewModel controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            itemCount: users.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final followData = users[index];
              if (controller.searchUserStr.isNotEmpty) {
                if (!(followData.userName ?? "")
                    .toLowerCase()
                    .contains(controller.searchUserStr.toLowerCase())) {
                  return SizedBox();
                }
              }
              return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseCollection.chatCollection
                      .doc(chatId(
                          (PreferenceUtils.getInt(key: 'userid')).toString(),
                          followData.id!))
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    }
                    if (snapshot.hasError) {
                      return SizedBox();
                    }
                    print('DATA ==>${snapshot.data!.exists}');
                    if (snapshot.data!.exists == false) {
                      return SizedBox();
                    }
                    return UserTile(
                      followData: followData,
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final FirebaseUserModel followData;

  const UserTile({Key? key, required this.followData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    return Column(
      children: [
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            Get.to(
              () => ChattingScreen(
                receiverFcmToken: followData.deviceToken ?? "",
                receiverName: followData.fullName ?? "",
                receiverImage: followData.userImage ?? "",
                receiverUserName: followData.userName ?? "",
                senderName:
                    PreferenceUtils.getString(key: PreferenceUtils.fullname),
                senderUserName:
                    PreferenceUtils.getString(key: PreferenceUtils.username),
                senderId: (PreferenceUtils.getInt(key: 'userid')).toString(),
                receiverId: followData.id.toString(),
                senderImage: PreferenceUtils.getString(key: 'profile'),
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
                  image: NetworkImage(followData.userImage ?? ""),
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
                  followData.userName ?? VariableUtils.naError,
                  fontSize: 13.sp,
                  color: blackWhite,
                  fontWeight: FontWeightClass.fontWeight600,
                ),
                SizeConfig.sH05,
              ],
            ),
            subtitle: LastMsg(
              receiverId: followData.id.toString(),
            ),
            trailing: MessageCount(
              receiverId: followData.id.toString(),
            ),
          ),
        ),
        Divider(indent: 10, endIndent: 20, color: black92White)
      ],
    );
  }
}

class MessageCount extends StatelessWidget {
  final String receiverId;

  const MessageCount({Key? key, required this.receiverId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseCollection.chatCollection
          .doc(chatId(
              (PreferenceUtils.getInt(key: 'userid')).toString(), receiverId))
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (!snapshot.data!.exists) {
            return UnSeenCountBox(count: 0);
          }
          if ((snapshot.data?.exists ?? false) == false) {
            return UnSeenCountBox(count: 0);
          }
          final mapData = snapshot.data!.data() as Map<String, dynamic>;
          if (mapData["message"].isEmpty) {
            return UnSeenCountBox(count: 0);
          }

          final count = (mapData["message"] as List<dynamic>)
              .where((element) =>
                  element["seen"] == false &&
                  element["receiverId"] ==
                      (PreferenceUtils.getInt(key: 'userid')).toString())
              .toList()
              .length;
          return UnSeenCountBox(count: count);
        }
        if (snapshot.hasError) {
          return UnSeenCountBox(count: 0);
        }

        return UnSeenCountBox(count: 0);
      },
    );
  }
}

class LastMsg extends StatelessWidget {
  final String receiverId;

  const LastMsg({Key? key, required this.receiverId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseCollection.chatCollection
          .doc(chatId(
              (PreferenceUtils.getInt(key: 'userid')).toString(), receiverId))
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (!snapshot.data!.exists) {
            return lastMsgText("");
          }
          if ((snapshot.data?.exists ?? false) == false) {
            return lastMsgText("");
          }
          final mapData = snapshot.data!.data() as Map<String, dynamic>;
          if (mapData["message"].isEmpty) {
            return lastMsgText("");
          }

          final messageList = (mapData["message"] as List<dynamic>);

          String lastMsg =
              messageList.last['messageType'] == MessageType.TEXT.name
                  ? messageList.last['message']
                  : messageList.last['messageType'] == MessageType.IMAGE.name
                      ? "📷 Photo"
                      : "🎥 Video";
          final lastMsgTime = (messageList.last['date'] as Timestamp).toDate();
          lastMsg = lastMsg.length > 100 ? lastMsg.substring(0, 100) : lastMsg;
          if (lastMsg.contains(DynamicLink.uriPrefix)) {
            lastMsg = "Post";
          }
          return lastMsgText(
              '$lastMsg · ${postTimeCalculate(lastMsgTime.toString(), "", isUtc: true)}');
        }
        if (snapshot.hasError) {
          return lastMsgText("");
        }

        return lastMsgText("");
      },
    );
  }

  AdoroText lastMsgText(String str) {
    return AdoroText(
      str,
      fontSize: 8.sp,
      color: ColorUtils.grey,
      maxLines: 2,
    );
  }
}

class UnSeenCountBox extends StatelessWidget {
  const UnSeenCountBox({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      child: AdoroText(
        count == 0 ? "" : "$count",
        fontSize: 8.sp,
        color: ColorUtils.white,
      ),
      decoration: count == 0
          ? BoxDecoration()
          : BoxDecoration(
              shape: BoxShape.circle,
              color: ColorUtils.blueB9,
            ),
    );
  }
}
