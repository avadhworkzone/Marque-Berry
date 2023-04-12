import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/get_follow_list_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: customAppbar(title: 'Tag friend', context: context),
      body: SafeArea(
        child: Padding(
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
                  denyInputFormatters: '[]',
                  allowInputFormatters: RegularExpression.alphabetDigitsPattern,
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
                  // if (getFollowerListResModel.status.toString() ==
                  //     VariableUtils.status500) {
                  //   return Center(
                  //     child: AdoroText(
                  //       getFollowerListResModel.msg ?? VariableUtils.somethingWentWrong,
                  //     ),
                  //   );
                  // }
                  return Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        itemCount: 25,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(radius: 7.w),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AdoroText(
                                      "Jane_ui ux",
                                      fontSize: 13.sp,
                                      color: ColorUtils.black,
                                      fontWeight: FontWeightClass.fontWeight600,
                                    ),
                                    SizeConfig.sH05,
                                  ],
                                ),
                                subtitle: AdoroText(
                                  'I don’t know · 2h ',
                                  fontSize: 10.sp,
                                  color: ColorUtils.black92,
                                ),
                              ),
                              DecorationUtils.dividerLine1(),
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
      ),
    );
  }

  var search = TextEditingController();
}
