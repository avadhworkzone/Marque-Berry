// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/browser_template_res.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/view/template/download_template_listview.dart';
import 'package:socialv/viewModel/template_view_model.dart';

import '../../commanWidget/common_image.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/variable_utils.dart';

class BrowserTemplate extends StatefulWidget {
  BrowserTemplate({Key? key}) : super(key: key);

  @override
  State<BrowserTemplate> createState() => _BrowserTemplateState();
}

class _BrowserTemplateState extends State<BrowserTemplate> {
  BrowserTemplateController browserTemplateController =
      Get.find<BrowserTemplateController>();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;

    // var search = TextEditingController();

    return Scaffold(
      appBar: customAppbar(title: "Browse Template", context: context),
      body: GetBuilder<TemplateViewModel>(
        builder: (templateViewModel) {
          return GetBuilder<BrowserTemplateController>(
            initState: (_) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                await templateViewModel.browserTemplate();
                browserTemplateController.changeTab(0);
                browserTemplateController.searchFunction("");
              });
            },
            builder: (browserTemplateController) {
              if (templateViewModel.browserTemplateApiResponse.status ==
                      Status.LOADING ||
                  templateViewModel.browserTemplateApiResponse.status ==
                      Status.INITIAL) {
                return Center(child: Loader());
              } else if (templateViewModel.browserTemplateApiResponse.status ==
                  Status.ERROR) {
                return Center(child: SomethingWentWrong());
              }
              final BrowserTemplateResModel browserResponse =
                  templateViewModel.browserTemplateApiResponse.data;
              if (browserResponse.status.toString() ==
                  VariableUtils.status500) {
                return AdoroText(browserResponse.msg ?? "");
              }

              List<Standard> standardList =
                  browserResponse.data?.standard ?? [];

              List<Standard> licensedList =
                  browserResponse.data?.licensed ?? [];

              if (browserTemplateController.search.isNotEmpty) {
                standardList = standardList
                    .where((element) => element.caption
                        .toString()
                        .contains(browserTemplateController.search))
                    .toList();

                licensedList = licensedList
                    .where((element) => element.caption
                        .toString()
                        .contains(browserTemplateController.search))
                    .toList();
              }

              return Column(
                children: [
                  SizeConfig.sH2,
                  Container(
                    width: 90.w,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26.withOpacity(0.2),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                          offset: const Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      cursorColor: blackWhite,
                      onChanged: (value) {
                        browserTemplateController.searchFunction(value);
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteBlack2E,
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: blackWhite),
                        counterText: "",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Icon(Icons.search, color: blackWhite),
                        ),
                        border: border,
                        focusedBorder: border,
                        enabledBorder: border,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.w,
                          vertical: 3.w,
                        ),
                      ),
                    ),
                  ),
                  SizeConfig.sH2,
                  Container(
                    height: 12.w,
                    width: 100.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: ColorUtils.transparent,
                          highlightColor: ColorUtils.transparent,
                          onTap: () => browserTemplateController.changeTab(0),
                          child: Column(
                            children: [
                              Spacer(),
                              Container(
                                width: 48.w,
                                child: Center(
                                  child: AdoroText(
                                    "Standard",
                                    color:
                                        browserTemplateController.tabIndex == 0
                                            ? ColorUtils.blueB9
                                            : black92White,
                                    fontWeight: FontWeightClass.fontWeight700,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 0.7.w,
                                width: 45.w,
                                color: browserTemplateController.tabIndex == 0
                                    ? ColorUtils.blueB9
                                    : ColorUtils.black92.withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          splashColor: ColorUtils.transparent,
                          highlightColor: ColorUtils.transparent,
                          onTap: () => browserTemplateController.changeTab(1),
                          child: Column(
                            children: [
                              Spacer(),
                              Container(
                                width: 48.w,
                                child: Center(
                                  child: AdoroText(
                                    "Licensed",
                                    fontWeight: FontWeightClass.fontWeight700,
                                    color:
                                        browserTemplateController.tabIndex == 1
                                            ? ColorUtils.blueB9
                                            : black92White,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 0.7.w,
                                width: 45.w,
                                color: browserTemplateController.tabIndex == 1
                                    ? ColorUtils.blueB9
                                    : ColorUtils.black92.withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizeConfig.sH3,
                  browserTemplateController.tabIndex == 0
                      ? standardList.isEmpty
                          ? Expanded(
                              child: Center(
                                child: AdoroText(VariableUtils.noDataFound),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: standardList.length,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 3.2.w,
                                  crossAxisSpacing: 3.2.w,
                                ),
                                itemBuilder: (c, i) {
                                  return InkWell(
                                    splashColor: ColorUtils.transparent,
                                    highlightColor: ColorUtils.transparent,
                                    onTap: () {
                                      Get.to(
                                        () => DownloadTemplateList(
                                          index: i,
                                          title: 'Standard',
                                          templateList: standardList,
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(1.5.w),
                                      child: OctoImage(
                                        fit: BoxFit.cover,
                                        width: 24,
                                        height: 24,
                                        image: NetworkImage(
                                          standardList[i].templateUrl ?? "",
                                        ),
                                        // fit: BoxFit.fill,
                                        progressIndicatorBuilder:
                                            (context, progress) {
                                          double? value;
                                          var expectedBytes =
                                              progress?.expectedTotalBytes;
                                          if (progress != null &&
                                              expectedBytes != null) {
                                            value =
                                                progress.cumulativeBytesLoaded /
                                                    expectedBytes;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: value,
                                              color: blackWhite,
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stacktrace) =>
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
                                  );
                                },
                              ),
                            )
                      : licensedList.isEmpty
                          ? Expanded(
                              child: Center(
                                child: AdoroText(VariableUtils.noDataFound),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: licensedList.length,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 3.2.w,
                                  crossAxisSpacing: 3.2.w,
                                ),
                                itemBuilder: (c, i) {
                                  return InkWell(
                                    splashColor: ColorUtils.transparent,
                                    highlightColor: ColorUtils.transparent,
                                    onTap: () {
                                      Get.to(
                                        () => DownloadTemplateList(
                                          index: i,
                                          title: 'Licensed',
                                          templateList:
                                              browserResponse.data!.licensed!,
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(1.5.w),
                                      child: OctoImage(
                                        fit: BoxFit.cover,
                                        width: 24,
                                        height: 24,
                                        image: NetworkImage(
                                          licensedList[i].templateUrl ?? '',
                                        ),
                                        // fit: BoxFit.fill,
                                        progressIndicatorBuilder:
                                            (context, progress) {
                                          double? value;
                                          var expectedBytes =
                                              progress?.expectedTotalBytes;
                                          if (progress != null &&
                                              expectedBytes != null) {
                                            value =
                                                progress.cumulativeBytesLoaded /
                                                    expectedBytes;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: value,
                                              color: blackWhite,
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stacktrace) =>
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
                                  );
                                },
                              ),
                            ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class BrowserTemplateController extends GetxController {
  int tabIndex = 0;
  changeTab(value) {
    tabIndex = value;
    update();
  }

  String search = "";
  searchFunction(value) {
    search = value;
    update();
  }
}
