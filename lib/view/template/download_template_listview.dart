import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';

import '../../commanWidget/common_appbar.dart';

class DownloadTemplateList extends StatelessWidget {
  final String title;

  final dynamic templateList;

  DownloadTemplateList({
    Key? key,
    required this.title,
    required this.templateList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    return Material(
      child: Column(
        children: [
          customAppbar(
            title: title,
            context: context,
            color: ColorUtils.transparent,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: templateList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(3.w),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                    child: Container(
                      width: 100.w,
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
                                  placeholderBuilder: OctoPlaceholder.blurHash(
                                    'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                  ),
                                  errorBuilder: (context, obj, stack) =>
                                      Image.asset(
                                    'assets/icons/user.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizeConfig.sH1AndHalf,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 13.w,
                                  width: 27.w,
                                  child: Image.asset(
                                    'assets/icons/share_icon_btn.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  height: 13.w,
                                  width: 30.w,
                                  child: Image.asset(
                                    'assets/icons/submit_icon_btn.png',
                                    fit: BoxFit.fill,
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
          ),
        ],
      ),
    );
  }
}
