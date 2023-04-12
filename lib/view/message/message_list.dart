import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/get_follow_list_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

class MessageList extends StatelessWidget {
  MessageList({Key? key}) : super(key: key);

  FollowRequestViewModel followRequestViewModel =
      Get.find<FollowRequestViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.w),
        child: CommonAppBar(
          title: 'Messages',
          ontap: () => Get.back(),
        ),
      ),
      body: GetBuilder<FollowRequestViewModel>(
        initState: (_) async {
          await followRequestViewModel.getFollowerList();
        },
        builder: (followRequestViewModel) {
          if (followRequestViewModel.getFollowerListApiResponse.status ==
                  Status.LOADING ||
              followRequestViewModel.getFollowerListApiResponse.status ==
                  Status.INITIAL) {
            return Center(child: Loader());
          } else if (followRequestViewModel.getFollowerListApiResponse.status ==
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
          return ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
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
          );
        },
      ),
    );
  }
}
