// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/utils/app_services/download_image.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';

import '../../commanWidget/common_appbar.dart';
import '../../utils/assets/images_utils.dart';

class DownloadTemplateList extends StatelessWidget {
  final String title;
  final int index;
  final dynamic templateList;

  DownloadTemplateList({
    Key? key,
    required this.title,
    required this.index,
    required this.templateList,
  }) : super(key: key);

  ScrollController scrollController = ScrollController();
  // ScrollController scrollController = ScrollController(initialScrollOffset: index * (75.w + 13.w + 6.h),);

  DownloadTemplateController downloadTemplateController =
      Get.find<DownloadTemplateController>();

  ImageDownload imageDownload = ImageDownload();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;

    return GetBuilder<DownloadTemplateController>(
      initState: (_) {
        scrollController = ScrollController(
          initialScrollOffset: index * (75.w + 13.w + 6.h),
        );
      },
      builder: (downloadTemplateController) {
        logs(index.toString());
        return Material(
          color: Theme.of(context).cardColor,
          child: Column(
            children: [
              customAppbar(
                title: title,
                context: context,
                color: ColorUtils.transparent,
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: templateList.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(3.w),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.w),
                            child: Container(
                              width: 100.w,
                              height: 75.w + 13.w + 6.h,
                              decoration: BoxDecoration(
                                color: whiteBlack2E,
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Column(
                                  children: [
                                    SizeConfig.sH3,
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(3.w),
                                      child: Container(
                                        height: 75.w,
                                        width: 100.w,
                                        child: OctoImage(
                                          height: 8.w,
                                          width: 8.w,
                                          image: NetworkImage(
                                            templateList[index].templateUrl,
                                          ),
                                          placeholderBuilder:
                                              OctoPlaceholder.blurHash(
                                            'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                          ),
                                          errorBuilder: (context, obj, stack) =>
                                              Image.asset(
                                            IconsWidgets.userImages,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizeConfig.sH1AndHalf,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            var path = await imageDownload
                                                .tempDownloadImage(
                                              templateList[index].templateUrl,
                                            );
                                            Share.shareXFiles([XFile(path)]);
                                          },
                                          child: Container(
                                            height: 13.w,
                                            width: 27.w,
                                            child: Image.asset(
                                              IconsWidgets.shareIconBtnImages,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            imageDownload.getStoragePermission(
                                              path: templateList[index]
                                                  .templateUrl,
                                            );
                                          },
                                          child: Container(
                                            height: 13.w,
                                            width: 35.w,
                                            child: Image.asset(
                                              IconsWidgets.submitIconBtnImages,
                                              // fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizeConfig.sH1AndHalf,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    if (downloadTemplateController.progress != "0%")
                      Center(
                        child: Container(
                          height: 20.w,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: ColorUtils.white,
                            borderRadius: BorderRadius.circular(4.w),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 3.0,
                                offset: const Offset(0, 0),
                                color: Colors.black26.withOpacity(0.2),
                              )
                            ],
                          ),
                          child: Center(
                            child: Loader(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DownloadTemplateController extends GetxController {
  String progress = "0%";

  void progressDownload(received, total) {
    progress = "0%";
    if (total != -1) {
      progress = (received / total * 100).toStringAsFixed(0) + "%";
      if (progress == "100%") {
        progress = "0%";
      }
      update();
    }
  }
}
