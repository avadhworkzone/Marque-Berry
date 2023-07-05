// ignore_for_file: must_be_immutable

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/appService/dynamic_link.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/variable_utils.dart';

import '../../utils/assets/images_utils.dart';

class ReferAndEarn extends StatefulWidget {
  ReferAndEarn({Key? key}) : super(key: key);

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  RxString referLink = "".obs;
  String referLinkWithDes = "";

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    final String referId =
        PreferenceUtils.getString(key: PreferenceUtils.referId);
    referLink.value =
        await DynamicLink.createDynamicLinkForReferAndErn(referId: referId);
    referLinkWithDes = """
Hey, I'm using adoro to network with brands, make meme and earn money.Join me! Download it here:
${referLink.value}
                   """;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(16.w),
        child: CommonAppBar(
          title: VariableUtils.referEarnText,
          onTap: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: size.height / 3.2,
                    width: size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        ImagesWidgets.referEarnImage,
                      ),
                      fit: BoxFit.fill,
                    )),
                    // padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(bottom: 18.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizeConfig.sH6,
                        AdoroText(
                          VariableUtils.referEarnText,
                          fontSize: 23.sp,
                          color: ColorUtils.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.w,
                    left: 8.w,
                    right: 8.w,
                    child: Container(
                      height: 23.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                            colors: [
                              ColorUtils.linearGradient7,
                              ColorUtils.linearGradient4,
                              ColorUtils.linearGradient5,
                              ColorUtils.linearGradient8,
                            ],
                            //   stops: [0, 0.3, 0.8],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        // border: Border.all(color: ColorUtils.black2E),
                        borderRadius: BorderRadius.circular(5.w),

                        boxShadow: [
                          BoxShadow(
                            color: ColorUtils.grey.withOpacity(0.5),
                            blurRadius: 1.w,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7.w, right: 7.w),
                            child: AdoroText(
                              'Copy the link below & share it with your friends',
                              color: ColorUtils.black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizeConfig.sH3,
                          Container(
                            height: 40,
                            width: 72.w,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.w),
                              color: ColorUtils.referEarn,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizeConfig.sW1,
                                CommonImageScale(
                                  img: IconsWidgets.linkImages,
                                  scale: 1.2.w,
                                  color: ColorUtils.black,
                                ),
                                Expanded(
                                    child: Obx(
                                  () => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: TextFormField(
                                      key: ValueKey(referLink.value),
                                      readOnly: true,
                                      initialValue: referLink.value,
                                      style: TextStyle(
                                        color: PreferenceUtils.getString(
                                                    key: 'mode') ==
                                                "dark"
                                            ? ColorUtils.black
                                            : ColorUtils.white,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10),
                                          fillColor: Colors.transparent,
                                          filled: true),
                                    ),
                                  ),
                                )),
                                InkWell(
                                  onTap: () {
                                    FlutterClipboard.copy(referLinkWithDes)
                                        .catchError((catchError) {})
                                        .then((value) {
                                      showSnackBar(
                                        message:
                                            VariableUtils.copiedSuccessfully,
                                        snackbarSuccess: true,
                                      );
                                    });
                                  },
                                  child: CommonImageScale(
                                    img: IconsWidgets.clipboardImages,
                                    scale: 1.5.w,
                                    color: ColorUtils.black,
                                  ),
                                ),
                                SizeConfig.sW2,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizeConfig.sH5,
              InkWell(
                splashColor: ColorUtils.transparent,
                highlightColor: ColorUtils.transparent,
                onTap: () {
                  Share.share(
                    referLinkWithDes,
                  );
                },
                child: Container(
                  width: 35.w,
                  child: Image.asset(
                    IconsWidgets.shareBtnImages,
                  ),
                ),
              ),
              SizeConfig.sH7,
              Padding(
                padding: EdgeInsets.only(left: 7.w, right: 7.w),
                child: AdoroText(
                  'When your friends will download the app with the referal code, you will get instant Rs. 2 in your wallet . ',
                  fontSize: 12.sp,
                  // textAlign: TextAlign.center,
                  color: Theme.of(context).textTheme.titleSmall?.color,
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 7.w, right: 7.w),
              //   child: AdoroText(
              //     'And when your friend earn its first earning , then you will also get 5% from there first earning',
              //     fontSize: 12.sp,
              //     textAlign: TextAlign.center,
              //     color: Theme.of(context).textTheme.titleSmall?.color,
              //   ),
              // ),
            ],
          ),
          Obx(
            () => referLink.value.isEmpty
                ? Container(
                    color: ColorUtils.black26,
                    width: Get.width,
                    height: Get.height,
                    child: Center(
                      child: Loader(),
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
