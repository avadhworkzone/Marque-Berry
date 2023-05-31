// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:socialv/appService/dynamic_link.dart';
import 'package:socialv/appService/notification_service.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/model/apiModel/responseModel/check_follow_user_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/notification_chating_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/view/home/components/video_components.dart';
import 'package:socialv/view/home/post_detail_screen.dart';
import 'package:socialv/view/profile/edit_profile.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

import '../profile/profile.dart';

class ChattingScreen extends StatefulWidget {
  String senderId;
  String receiverId;

  String senderName;
  String receiverName;
  String receiverFcmToken;

  String senderImage;
  String receiverImage;

  ChattingScreen(
      {Key? key,
      required this.senderId,
      required this.receiverId,
      required this.senderName,
      required this.receiverName,
      required this.senderImage,
      required this.receiverImage,
      required this.receiverFcmToken})
      : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen>
    with WidgetsBindingObserver {
  var message = TextEditingController(text: "");
  ChattingController chattingController = Get.find<ChattingController>();
  FollowFollowingViewModel followingViewModel =
      Get.find<FollowFollowingViewModel>();
  RxBool isMsgSending = false.obs;
  bool isUserFollowed = false;

  @override
  void initState() {
    super.initState();
    widget.senderImage =
        PreferenceUtils.getString(key: PreferenceUtils.profileImage);
    ConstUtils.selectedChattingUserId = widget.receiverId;
    seenOldMessage();
    checkUserFollow();
  }

  Future<void> checkUserFollow() async {
    await followingViewModel.checkFollow(widget.receiverId);
    if (followingViewModel.checkFollowApiResponse.status == Status.COMPLETE) {
      CheckFollowUserResModel userResModel =
          followingViewModel.checkFollowApiResponse.data;
      if (userResModel.status == 200) {
        if ((userResModel.data?.first.followStatus ?? 'false') == "true") {
          isUserFollowed = true;
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (
        // state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      ConstUtils.selectedChattingUserId = "";
    } else if (state == AppLifecycleState.resumed) {
      ConstUtils.selectedChattingUserId = widget.receiverId;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ConstUtils.selectedChattingUserId = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    return WillPopScope(
      onWillPop: () {
        seenOldMessage();
        return Future.value(true);
      },
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: ColorUtils.transparent,
          titleSpacing: 0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    seenOldMessage();
                    Get.back();
                  },
                  splashRadius: 6.w,
                  icon: Icon(Icons.arrow_back, color: blackWhite),
                ),
                SizeConfig.sW2,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Container(
                    color: Colors.grey[200],
                    height: 10.w,
                    width: 10.w,
                    child: OctoImage(
                      image: NetworkImage(scale: 1.3.w, widget.receiverImage),
                      placeholderBuilder: OctoPlaceholder.blurHash(
                        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                      ),
                      errorBuilder: (context, obj, stack) => Image.asset(
                        // 'assets/images/profile.png',
                        IconsWidgets.userImages,
                        scale: 4,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizeConfig.sW2,
                AdoroText(
                  widget.receiverName,
                  color: blackWhite,
                  fontSize: 15.sp,
                  fontWeight: FontWeightClass.fontWeight600,
                ),
                // AdoroText(
                //   "2H",
                //   fontSize: 15.sp,
                //   color: greyFABlack32,
                //   fontWeight: FontWeightClass.fontWeight600,
                // ),
              ],
            ),
          ),
        ),

        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Chat")
                          .doc(chatId(widget.senderId, widget.receiverId))
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Padding(
                            padding: EdgeInsets.only(bottom: 30.h),
                            child: Loader(),
                          ));
                        }

                        if (snapshot.hasError) {
                          return SizedBox();
                        }
                        if (!snapshot.data.exists) {
                          return SizedBox();
                        }
                        if (!snapshot.hasData) {
                          return SizedBox();
                        } else {
                          if (snapshot.data!["message"].length < 1)
                            return SizedBox();
                          else
                            return ListView.builder(
                              shrinkWrap: true,
                              primary: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!["message"].length,
                              itemBuilder: (context, index) {
                                String messageTypeFirebase =
                                    snapshot.data?["message"][index]["messageType"];
                                String senderIdFirebase =
                                    snapshot.data?["message"][index]["senderId"];
                                String messageFirebase =
                                    snapshot.data?["message"][index]["message"];

                                /// DATE CONVERTER
                                final Timestamp timestamp =
                                    snapshot.data?["message"][index]["date"];
                                final DateTime dateTime = timestamp.toDate();
                                final timeConvert =
                                    DateFormat('hh:mm a').format(dateTime);

                                ///

                                if (messageTypeFirebase ==
                                    MessageType.TEXT.name.toString()) {
                                  return senderIdFirebase == widget.senderId
                                      ? RightAlignTextWidget(
                                          message: messageFirebase,
                                          date: timeConvert,
                                          senderImage: widget.senderImage,
                                          userId: widget.senderId,
                                        )
                                      : LeftAlignTextWidget(
                                          userId: widget.receiverId,
                                          receiverImage: widget.receiverImage,
                                          message: messageFirebase,
                                          date: timeConvert,
                                        );
                                } else if (messageTypeFirebase ==
                                    MessageType.VIDEO.name) {
                                  return senderIdFirebase == widget.senderId
                                      ? RightImageWidget(
                                          sImage: widget.senderImage,
                                          time: timeConvert,
                                          image: messageFirebase,
                                          isVideo: true,
                                          userId: widget.senderId,
                                        )
                                      : LeftImageWidget(
                                          rImage: widget.receiverImage,
                                          time: timeConvert,
                                          isVideo: true,
                                          image: messageFirebase,
                                          userId: widget.receiverId,
                                        );
                                } else if (messageTypeFirebase ==
                                    MessageType.IMAGE.name) {
                                  return senderIdFirebase == widget.senderId
                                      ? RightImageWidget(
                                          sImage: widget.senderImage,
                                          time: timeConvert,
                                          image: messageFirebase,
                                          isVideo: false,
                                          userId: widget.senderId,
                                        )
                                      : LeftImageWidget(
                                          rImage: widget.receiverImage,
                                          time: timeConvert,
                                          isVideo: false,
                                          image: messageFirebase,
                                          userId: widget.receiverId,
                                        );
                                }
                                return SizedBox();
                              },
                            );
                        }
                      },
                    ),
                    GetBuilder<ChattingController>(builder: (chattingController) {
                      print(
                          'chattingController._sourcePath=>${chattingController._sourcePath}');
                      String ext = chattingController._sourcePath.split("/").last;
                      print('EXT ===>$ext');
                      if (ext.contains("jpg") ||
                          ext.contains("png") ||
                          ext.contains("jpeg")) {
                        if (chattingController._sourcePath != "")
                          return TempImageWidget(
                            isVideo: false,
                            image: chattingController._sourcePath,
                            sImage: widget.senderImage,
                            time: '',
                            userId: widget.senderId,
                          );
                        return SizedBox();
                      } else if (chattingController._sourcePath != "")
                        return TempImageWidget(
                          isVideo: true,
                          image: chattingController._sourcePath,
                          sImage: widget.senderImage,
                          time: '',
                          userId: widget.senderId,
                        );
                      return SizedBox();
                    }),
                  ],
                ),
              ),
            ),
            textFormWidget(
              chattingController: chattingController,
              color: blackWhite,
              context: context,
            )
          ],
        ),
      ),
    );
  }

  Widget textFormWidget({
    Color? color,
    required ChattingController chattingController,
    required BuildContext context,
  }) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      height: 16.w,
      color: greyFABlack32,
      child: Row(
        children: [
          SizeConfig.sW2,
          InkWell(
            onTap: () async {
              var getPath = await chattingController.pickFile();

              if (getPath != "") {
                uploadImgFirebaseStorage(
                  chattingController: chattingController,
                  ext: getPath.split(".").last,
                  file: getPath,
                );
              }
            },
            child: Container(
              width: 9.w,
              height: 9.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.w),
                color: ColorUtils.blueB9,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.w),
                child: Image.asset("assets/icons/camera.png"),
              ),
            ),
          ),
          SizeConfig.sW2,
          Expanded(
            child: TextFormField(
              controller: message,
              cursorColor: blackWhite,
              style: TextStyle(color: blackWhite),
              decoration: InputDecoration(
                filled: true,
                fillColor: whiteBlack2E,
                hintText: 'Message...',
                hintStyle: TextStyle(color: blackWhite),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorUtils.grey.shade200),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorUtils.grey.shade200),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          SizeConfig.sW2,
          Obx(() => InkWell(
                onTap: isMsgSending.value
                    ? null
                    : () async {
                        if (message.text.isNotEmpty) {
                          await sendMessage(
                            message: message.text,
                            messageType: MessageType.TEXT,
                          );

                          message.clear();
                        }
                      },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorUtils.transparent,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child:
                          Icon(Icons.send_sharp, size: 8.w, color: blackWhite),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  /// ======================SEEN OLD MSG===========================
  Future<void> seenOldMessage() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(widget.senderId, widget.receiverId))
        .get();
    if (!data.exists) {
      return;
    }
    List body = data.get('message');
    body.forEach((element) {
      if (widget.senderId == element['receiverId']) {
        element['seen'] = true;
      }
    });

    FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(widget.senderId, widget.receiverId))
        .update({'message': body});
  }

  Future<void> sendMessage({
    required String message,
    required MessageType messageType,
  }) async {
    try {
      // FocusScope.of(context).unfocus();
      isMsgSending.value = true;

      if (!isUserFollowed) {
        showSnackBar(
          message: "Please first follow this user",
          snackbarSuccess: true,
        );
        return;
      }
      bool exists = (await FirebaseFirestore.instance
              .collection("Chat")
              .doc(chatId(widget.senderId, widget.receiverId))
              .get())
          .exists;
      if (exists == false) {
        await FirebaseFirestore.instance
            .collection("Chat")
            .doc(chatId(widget.senderId, widget.receiverId))
            .set({"message": {}});
      }

      await FirebaseFirestore.instance
          .collection("Chat")
          .doc(chatId(widget.senderId, widget.receiverId))
          .update(
        {
          "message": FieldValue.arrayUnion([
            {
              'date': DateTime.now(),
              "message": message,
              'senderId': widget.senderId,
              'receiverId': widget.receiverId,
              "seen": false,
              "document": chatId(widget.senderId, widget.receiverId),
              "messageType": messageType.name,
            }
          ]),
          "last_message_time": DateTime.now().millisecondsSinceEpoch,
          'senderId': widget.senderId,
          'receiverId': widget.receiverId,
        },
      ).then((value) async {
        final deviceToken = await NotificationService.getDeviceToken();
        final messageData = NotificationChattingModel(
          receiverFcmToken: deviceToken,
          receiverId: widget.senderId,
          receiverImage: widget.senderImage,
          receiverName: widget.senderName,
          senderId: widget.receiverId,
          senderImage: widget.receiverImage,
          senderName: widget.receiverName,
        );

        NotificationService.sendMessage(
            receivedToken: widget.receiverFcmToken,
            msg: messageType == MessageType.TEXT
                ? message
                : messageType == MessageType.IMAGE
                    ? "📷 Photo"
                    : '🎥 Video',
            title: widget.senderName,
            data: {
              'data': messageData.toJson(),
              'id': DateTime.now().millisecond.toString(),
              'notification_type': NotificationType.Chatting.name
            });
      });
    } catch (e) {
      logs("no message:----> $e");
    } finally {
      isMsgSending.value = false;
    }
  }

  /// ====================== Image upload ===========================
  uploadImgFirebaseStorage({
    required String file,
    required String ext,
    required ChattingController chattingController,
  }) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;

      if (ext == "jpg" || ext == "jpeg" || ext == "png") {
        var snapshot = await storage
            .ref()
            .child('ChatImage/${DateTime.now().microsecondsSinceEpoch}')
            .putFile(File(file));
        String downloadUrl = await snapshot.ref.getDownloadURL();

        await sendMessage(
          message: downloadUrl,
          messageType: MessageType.IMAGE,
        );
      } else if (ext == "mkv" ||
          ext == "mp4" ||
          ext == "mov" ||
          ext == "wmv" ||
          ext == "mpg" ||
          ext == "gif") {
        var snapshot = await storage
            .ref()
            .child('ChatVideos/${DateTime.now().microsecondsSinceEpoch}')
            .putFile(File(file));
        String downloadUrl = await snapshot.ref.getDownloadURL();

        await sendMessage(
          message: downloadUrl,
          messageType: MessageType.VIDEO,
        );
      }

      chattingController.sourcePath = "";
    } catch (e) {
      logs("not uploaded:-----> $e");
    } finally {
      chattingController._sourcePath = "";
    }
  }
}

/// ==================== Left image =======================

class LeftImageWidget extends StatelessWidget {
  final String image;
  final String time;
  final String rImage;
  final String userId;

  bool? isVideo = false;

  LeftImageWidget({
    super.key,
    this.isVideo,
    required this.image,
    required this.rImage,
    required this.time,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => Profile(
                        userId: int.parse(userId),
                      ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Container(
                    height: 9.w,
                    width: 9.w,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: chattingProfileImage(image: rImage),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: isVideo == true
                      ? () {
                          Get.dialog(
                            Dialog(
                              insetPadding: EdgeInsets.zero,
                              child: Container(
                                color: Colors.black26,
                                child: Center(
                                  child: AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: FileVideoPlayer(url: image),
                                  ),
                                  // BetterPlayer.network(image),
                                ),
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Card(
                    color: Colors.grey[100],
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizeConfig.sH1AndHalf,
                        if (isVideo == true)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 60.w,
                              width: 55.w,
                              child: Icon(
                                Icons.play_circle_outline,
                                size: 20.w,
                                color: ColorUtils.black,
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10, left: 10),
                            child: Container(
                              height: 60.w,
                              width: 55.w,
                              child: InkWell(
                                  onTap: () {
                                    Get.to(() => Dialog(
                                          child: PhotoView(
                                            imageProvider: NetworkImage(
                                              image,
                                            ),
                                          ),
                                        ));
                                  },
                                  child:
                                      Image.network(image, fit: BoxFit.cover)),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: AdoroText(time, fontSize: 9.sp),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizeConfig.sH1AndHalf,
        ],
      ),
    );
  }
}

class RightImageWidget extends StatelessWidget {
  final String image;
  final String time;
  final String sImage;
  final String userId;

  bool? isVideo = false;

  RightImageWidget({
    super.key,
    required this.isVideo,
    required this.image,
    required this.sImage,
    required this.time,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: isVideo == true
                      ? () {
                          Get.dialog(
                            Dialog(
                              backgroundColor: Colors.black87,
                              insetPadding: EdgeInsets.zero,
                              child: Center(
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: FileVideoPlayer(url: image),
                                ),
                                // BetterPlayer.network(image),
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Card(
                    elevation: 0, color: Colors.grey[100],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    //child:
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizeConfig.sH1AndHalf,
                        if (isVideo == true)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 60.w,
                              width: 55.w,
                              child: Icon(
                                Icons.play_circle_outline,
                                size: 20.w,
                                color: ColorUtils.black,
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10, left: 10),
                            child: InkWell(
                              onTap: () {
                                Get.dialog(
                                  Dialog(
                                    backgroundColor: Colors.black87,
                                    insetPadding: EdgeInsets.zero,
                                    child: Center(
                                      child: PhotoView(
                                        errorBuilder: (context, error, stackTrace) {
                                          return CommonImage(
                                            img: IconsWidgets.imageImages,
                                            color: ColorUtils.black,
                                          );
                                        },
                                        loadingBuilder: (context, event) {
                                          return Loader();
                                        },
                                        backgroundDecoration: BoxDecoration(
                                          color: Colors.transparent
                                        ),
                                        imageProvider: NetworkImage(
                                          image,
                                        ),
                                      )
                                    ),
                                  ),
                                );
                                // Get.to(() => Dialog(
                                //       child: PhotoView(
                                //         imageProvider: NetworkImage(
                                //           image,
                                //         ),
                                //       ),
                                //     ));
                              },
                              child: Container(
                                height: 60.w,
                                width: 55.w,
                                child: Image.network(image, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child: AdoroText(
                            time,
                            fontSize: 9.sp,
                            color: ColorUtils.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    Get.to(() => Profile(
                          userId: int.parse(userId),
                        ));
                  },
                  child: LeftRightSideUserImage(sImage: sImage)),
            ],
          ),
          SizeConfig.sH1AndHalf,
        ],
      ),
    );
  }
}

class TempImageWidget extends StatelessWidget {
  final String image;
  final String time;
  final String sImage;
  final String userId;
  bool? isVideo = false;

  TempImageWidget({
    super.key,
    required this.isVideo,
    required this.image,
    required this.sImage,
    required this.time,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: isVideo == true
                      ? () {
                          Get.dialog(
                            Dialog(
                              // backgroundColor: Colors.red,
                              insetPadding: EdgeInsets.zero,
                              child: Center(
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: FileVideoPlayer(
                                    url: image,
                                    fileVideo: true,
                                  ),
                                ),
                                // BetterPlayer.file(image),
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Card(
                    elevation: 0, color: Colors.grey[100],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    //child:
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizeConfig.sH1AndHalf,
                        if (isVideo == true)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 60.w,
                              width: 55.w,
                              child: Icon(
                                Icons.play_circle_outline,
                                size: 20.w,
                                color: ColorUtils.black,
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10, left: 10),
                            child: Container(
                              height: 60.w,
                              width: 55.w,
                              child: Image.file(File(image), fit: BoxFit.cover),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child: AdoroText(time, fontSize: 9.sp),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    Get.to(() => Profile(
                          userId: int.parse(userId),
                        ));
                  },
                  child: LeftRightSideUserImage(
                    sImage: sImage,
                  )),
            ],
          ),
          SizeConfig.sH1AndHalf,
        ],
      ),
    );
  }
}

class LeftRightSideUserImage extends StatelessWidget {
  const LeftRightSideUserImage({
    super.key,
    required this.sImage,
  });

  final String sImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.w),
      child: Container(
        height: 9.w,
        width: 9.w,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: chattingProfileImage(image: sImage),
        ),
      ),
    );
  }
}

/// ==================== Left text =======================

class LeftAlignTextWidget extends StatelessWidget {
  final String date;
  final String message;
  final String receiverImage;
  final String userId;

  const LeftAlignTextWidget({
    super.key,
    required this.receiverImage,
    required this.message,
    required this.date,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => Profile(
                        userId: int.parse(userId),
                      ));
                  print("chattingProfileImage");
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: chattingProfileImage(image: receiverImage),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Card(
                    elevation: 0,
                    color: Colors.grey[100],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: !message.contains(DynamicLink.uriPrefix)
                                  ? null
                                  : () {
                                      final postId = message
                                          .toString()
                                          .substring(
                                              message.toString().indexOf('=') +
                                                  1);
                                      Get.to(() => PostDetailScreen(
                                            postId: postId,
                                            isFromBackScreen: true,
                                          ));
                                    },
                              child: AdoroText(
                                message,
                                color: message.contains(DynamicLink.uriPrefix)
                                    ? ColorUtils.blueB9
                                    : ColorUtils.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: AdoroText(
                              date,
                              fontSize: 9.sp,
                              color: ColorUtils.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizeConfig.sH1AndHalf,
        ],
      ),
    );
  }
}

class RightAlignTextWidget extends StatelessWidget {
  final String date;
  final String message;
  final String senderImage;
  final String userId;

  const RightAlignTextWidget({
    super.key,
    required this.senderImage,
    required this.message,
    required this.date,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Card(
                    color: Colors.grey[100],
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: !message.contains(DynamicLink.uriPrefix)
                                  ? null
                                  : () {
                                      final postId = message
                                          .toString()
                                          .substring(
                                              message.toString().indexOf('=') +
                                                  1);
                                      Get.to(
                                        () => PostDetailScreen(
                                            postId: postId,
                                            isFromBackScreen: true),
                                      );
                                    },
                              child: AdoroText(
                                message,
                                color: message.contains(DynamicLink.uriPrefix)
                                    ? ColorUtils.blueB9
                                    : ColorUtils.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: AdoroText(
                              date,
                              fontSize: 9.sp,
                              color: ColorUtils.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => Profile(
                        userId: int.parse(userId),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: chattingProfileImage(image: senderImage),
                ),
              ),
              SizeConfig.sW4,
            ],
          ),
          SizeConfig.sH1AndHalf,
        ],
      ),
    );
  }
}

/// =============== CHATTING PROFILE IMAGE ================

Widget chattingProfileImage({required String image}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.w),
    child: Container(
      color: Colors.grey[100],
      child: OctoImage(
        height: 8.w,
        width: 8.w,
        image: NetworkImage(image),
        placeholderBuilder: OctoPlaceholder.blurHash(
          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
        ),
        errorBuilder: (context, obj, stack) =>
            Image.asset(IconsWidgets.userImages),
        fit: BoxFit.cover,
      ),
    ),
  );
}

/// ==================== Controller =======================

class ChattingController extends GetxController {
  String _sourcePath = "";

  String get sourcePath => _sourcePath;

  set sourcePath(String value) {
    _sourcePath = value;
    update();
  }

  Future<String> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'mp4',
          'mov',
          'wmv',
          'avi',
          'mpg',
          '3gp',
          'mkv',
          "gif"
        ],
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        _sourcePath = file.path!;
        if (_sourcePath.contains('.jpg') ||
            _sourcePath.contains('.jpeg') ||
            _sourcePath.contains('.png')) {
          final cropImagePath = await cropImageClass.postCropImage(
            image: File(file.path!),
            isBackGround: true,
          );
          if (cropImagePath != null) {
            _sourcePath = cropImagePath.path;
          }
        }
      } else {
        _sourcePath = "";
      }
      update();
      return _sourcePath;
    } catch (e) {
      showSnackBar(message: "Permission is required.");
      logs("message:=====> $e");
      return '';
    }
  }

  clearSourcePath() {
    _sourcePath = "";
    update();
  }
}

/// ================ MESSAGE ENUM ===============

enum MessageType { TEXT, VIDEO, IMAGE }
