import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/get_follower_list_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

import '../../commanWidget/common_image.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';

class TagAPeople extends StatelessWidget {
  TagAPeople({Key? key}) : super(key: key);

  FollowRequestViewModel followRequestViewModel =
      Get.find<FollowRequestViewModel>();
  var search = TextEditingController();
  TagAPeopleController tagAPeopleController = Get.find<TagAPeopleController>();

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    return GetBuilder<TagAPeopleController>(
      initState: (_) {
        tagAPeopleController.longPressTrue(false);
        tagAPeopleController.clearList();
      },
      builder: (tagAPeopleController) {
        return Scaffold(
          appBar: customAppbar(
            title: 'Tag friend',
            context: context,
            icon: tagAPeopleController.isLongPress == true
                ? IconButton(
                    onPressed: () {
                      tagAPeopleController.longPressTrue(false);
                    },
                    icon: Icon(Icons.close, color: blackWhite),
                  )
                : SizedBox(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.w),
            child: Column(
              children: [
                SizeConfig.sH1,
                Container(
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
                  child: SearchTextFormField(
                    color: Theme.of(context).textTheme.titleSmall?.color,
                    validator: () {},
                    controller: search,
                    denyInput: false,
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: blackWhite),
                    denyInputFormatters: '[]',
                    allowInputFormatters:
                        RegularExpression.alphabetDigitsPattern,
                  ),
                ),
                SizeConfig.sH2,
                GetBuilder<FollowRequestViewModel>(
                  initState: (_) async {
                    await followRequestViewModel.getFollowerList();
                  },
                  builder: (followRequestViewModel) {
                    if (followRequestViewModel
                                .getFollowerListApiResponse.status ==
                            Status.LOADING ||
                        followRequestViewModel
                                .getFollowerListApiResponse.status ==
                            Status.INITIAL) {
                      return Center(child: Loader());
                    } else if (followRequestViewModel
                            .getFollowerListApiResponse.status ==
                        Status.ERROR) {
                      return Center(child: SomethingWentWrong());
                    }
                    final GetFollowerListResModel getFollowerListResModel =
                        followRequestViewModel.getFollowerListApiResponse.data;
                    if (getFollowerListResModel.status.toString() ==
                        VariableUtils.status500) {
                      return Center(
                        child: AdoroText(
                          getFollowerListResModel.msg ??
                              VariableUtils.somethingWentWrong,
                        ),
                      );
                    }
                    return Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: getFollowerListResModel.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final followData =
                                getFollowerListResModel.data?[index];
                            return Column(
                              children: [
                                InkWell(
                                  onTap:
                                      tagAPeopleController.isLongPress == true
                                          ? null
                                          : () {
                                              tagAPeopleController
                                                  .longPressTrue(true);
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
                                          image: NetworkImage(
                                            followData?.image ?? "",
                                          ),
                                          progressIndicatorBuilder:
                                              (context, progress) {
                                            double? value;
                                            var expectedBytes =
                                                progress?.expectedTotalBytes;
                                            if (progress != null &&
                                                expectedBytes != null) {
                                              value = progress
                                                      .cumulativeBytesLoaded /
                                                  expectedBytes;
                                            }
                                            return Center(child: Loader());
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
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AdoroText(
                                          followData?.username ??
                                              VariableUtils.naError,
                                          fontSize: 13.sp,
                                          color: blackWhite,
                                          fontWeight:
                                              FontWeightClass.fontWeight600,
                                        ),
                                        SizeConfig.sH05,
                                      ],
                                    ),
                                    subtitle: AdoroText(
                                      followData?.fullName ?? "",
                                      fontSize: 10.sp,
                                      color: ColorUtils.black92,
                                    ),
                                    trailing: tagAPeopleController
                                                .isLongPress ==
                                            true
                                        ? Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: blackWhite ??
                                                    ColorUtils.black,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(1.w),
                                              child: tagAPeopleController
                                                          .tagList
                                                          .indexWhere((element) =>
                                                              element.id
                                                                      .toString() ==
                                                                  followData?.id
                                                                      .toString() &&
                                                              element.username ==
                                                                  followData
                                                                      ?.username) >
                                                      -1
                                                  ? InkWell(
                                                      highlightColor: ColorUtils
                                                          .transparent,
                                                      splashColor: ColorUtils
                                                          .transparent,
                                                      onTap: () {
                                                        tagAPeopleController
                                                            .removeList(
                                                          followData?.id,
                                                          followData?.username,
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.check,
                                                        size: 5.w,
                                                        color: blackWhite,
                                                      ),
                                                    )
                                                  : InkWell(
                                                      highlightColor: ColorUtils
                                                          .transparent,
                                                      splashColor: ColorUtils
                                                          .transparent,
                                                      onTap: () {
                                                        tagAPeopleController
                                                            .addList(
                                                          followData?.id,
                                                          followData?.username,
                                                        );
                                                        logs("2 add karvana");
                                                      },
                                                      child: Container(
                                                        height: 5.w,
                                                        width: 5.w,
                                                      ),
                                                    ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                                DecorationUtils.dividerLine1(),

                                ///

                                // ListView.builder(
                                //   shrinkWrap: true,
                                //   itemCount:
                                //       tagAPeopleController.tagList.length ?? 0,
                                //   itemBuilder: (c, i) {
                                //     return Text(
                                //       '${tagAPeopleController.tagList[i].username}   ${tagAPeopleController.tagList.length}',
                                //     );
                                //   },
                                // ),

                                ///
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class TagAPeopleController extends GetxController {
  bool isLongPress = false;
  List<TagAPeopleClass> tagList = [];

  longPressTrue(value) {
    isLongPress = value;
    update();
  }

  addList(id, username) {
    tagList.add(TagAPeopleClass(username: username, id: id));
    update();
  }

  removeList(id, username) {
    int tagListIndex = tagList.indexWhere(
      (element) => element.username == username && element.id == id,
    );

    tagList.removeAt(tagListIndex);
    update();
  }

  clearList() {
    tagList.clear();
  }
}

class TagAPeopleClass {
  var id;
  var username;

  TagAPeopleClass({this.id, this.username});
}
