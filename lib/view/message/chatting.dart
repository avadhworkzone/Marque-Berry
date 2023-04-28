// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class ChattingScreen extends StatefulWidget {
  String senderId;
  String receiverId;

  String senderName;
  String receiverName;

  String senderImage;
  String receiverImage;

  ChattingScreen({
    Key? key,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.senderImage,
    required this.receiverImage,
  }) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  var message = TextEditingController(text: "");
  ChattingController chattingController = Get.find<ChattingController>();

  @override
  void initState() {
    super.initState();
    seenOldMessage();
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
            // height: 16.w,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
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
                        'assets/images/profile.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizeConfig.sW1,
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
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Chat")
                    .doc(chatId(widget.senderId, widget.receiverId))
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Loader());
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
                      return SingleChildScrollView(
                        reverse: true,
                        child: ListView.builder(
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

                            ///
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
                                    )
                                  : LeftAlignTextWidget(
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
                                    )
                                  : LeftImageWidget(
                                      rImage: widget.receiverImage,
                                      time: timeConvert,
                                      isVideo: true,
                                      image: messageFirebase,
                                    );
                            } else if (messageTypeFirebase ==
                                MessageType.IMAGE.name) {
                              return senderIdFirebase == widget.senderId
                                  ? RightImageWidget(
                                      sImage: widget.senderImage,
                                      time: timeConvert,
                                      image: messageFirebase,
                                      isVideo: false,
                                    )
                                  : LeftImageWidget(
                                      rImage: widget.receiverImage,
                                      time: timeConvert,
                                      isVideo: false,
                                      image: messageFirebase,
                                    );
                            }
                            return SizedBox();
                          },
                        ),
                      );
                  }
                },
              ),
            ),

            GetBuilder<ChattingController>(builder: (chattingController) {
              String ext = chattingController._sourcePath.split("/").last;
              if (ext == "jpg" || ext == "png" || ext == "jpeg") {
                if (chattingController._sourcePath != "")
                  return TempImageWidget(
                    isVideo: false,
                    image: chattingController._sourcePath,
                    sImage: widget.senderImage,
                    time: '',
                  );
                return SizedBox();
              } else if (chattingController._sourcePath != "")
                return TempImageWidget(
                  isVideo: true,
                  image: chattingController._sourcePath,
                  sImage: widget.senderImage,
                  time: '',
                );
              return SizedBox();
            }),
            // Image.file(File(chattingController._sourcePath)),
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
          InkWell(
            onTap: () async {
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
                  child: Icon(Icons.send_sharp, size: 8.w, color: blackWhite),
                ),
              ),
            ),
          )
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
          .update({
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
        ])
      });
    } catch (e) {
      logs("no message:----> $e");
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

  bool? isVideo = false;

  LeftImageWidget({
    super.key,
    this.isVideo,
    required this.image,
    required this.rImage,
    required this.time,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: Container(
                  height: 9.w,
                  width: 9.w,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: OctoImage(
                        height: 8.w,
                        width: 8.w,
                        image: NetworkImage(rImage),
                        placeholderBuilder: OctoPlaceholder.blurHash(
                          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                        ),
                        errorBuilder: (context, obj, stack) => Image.asset(
                          'assets/images/profile_dummy.png',
                        ),
                        fit: BoxFit.cover,
                      ),
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
                                    child: BetterPlayer.network(image),
                                  ),
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
                              child: Image.network(image, fit: BoxFit.cover),
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
  bool? isVideo = false;

  RightImageWidget({
    super.key,
    required this.isVideo,
    required this.image,
    required this.sImage,
    required this.time,
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
                                  child: BetterPlayer.network(image),
                                ),
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
                            child: Container(
                              height: 60.w,
                              width: 55.w,
                              child: Image.network(image, fit: BoxFit.cover),
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
              LeftRightSideUserImage(sImage: sImage),
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
  bool? isVideo = false;

  TempImageWidget({
    super.key,
    required this.isVideo,
    required this.image,
    required this.sImage,
    required this.time,
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
                              backgroundColor: Colors.red,
                              insetPadding: EdgeInsets.zero,
                              child: Center(
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: BetterPlayer.file(image),
                                ),
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
              LeftRightSideUserImage(sImage: sImage),
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: OctoImage(
              height: 8.w,
              width: 8.w,
              image: NetworkImage(sImage),
              placeholderBuilder: OctoPlaceholder.blurHash(
                'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
              ),
              errorBuilder: (context, obj, stack) => Image.asset(
                'assets/images/profile_dummy.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
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

  const LeftAlignTextWidget({
    super.key,
    required this.receiverImage,
    required this.message,
    required this.date,
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
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: OctoImage(
                    height: 8.w,
                    width: 8.w,
                    image: NetworkImage(receiverImage),
                    placeholderBuilder: OctoPlaceholder.blurHash(
                      'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                    ),
                    errorBuilder: (context, obj, stack) => Image.asset(
                      'assets/icons/user.png',
                    ),
                    fit: BoxFit.cover,
                  ),
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
                            child: AdoroText(
                              message,
                              color: ColorUtils.black,
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

  const RightAlignTextWidget({
    super.key,
    required this.senderImage,
    required this.message,
    required this.date,
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
                            child: AdoroText(message, color: ColorUtils.black),
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
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: OctoImage(
                    height: 8.w,
                    width: 8.w,
                    image: NetworkImage(senderImage),
                    placeholderBuilder: OctoPlaceholder.blurHash(
                      'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                    ),
                    errorBuilder: (context, obj, stack) => Image.asset(
                      'assets/images/profile_dummy.png',
                    ),
                    fit: BoxFit.cover,
                  ),
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

/// ============ MESSAGE ENUM =============================

enum MessageType { TEXT, VIDEO, IMAGE }
