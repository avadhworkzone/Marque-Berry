// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/note_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/viewModel/drawer_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/variable_utils.dart';

class Note extends StatelessWidget {
  Note({
    Key? key,
  }) : super(key: key);

  final DrawerVideModel viewModel = Get.find<DrawerVideModel>();

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size(100.w, 60),
        child: CommonAppBar(
            title: VariableUtils.note,
            onTap: () => Get.back(),
            color: Theme.of(context).cardColor),
      ),
      body: GetBuilder<DrawerVideModel>(initState: (_) {
        viewModel.getNote();
      }, builder: (con) {
        if (con.getNoteApiResponse.status == Status.LOADING ||
            con.getNoteApiResponse.status == Status.INITIAL) {
          return Center(child: Loader());
        } else if (con.getNoteApiResponse.status == Status.ERROR) {
          return Center(child: SomethingWentWrong());
        }
        final NoteResModel noteResModel = con.getNoteApiResponse.data;
        if (noteResModel.status != 200 || noteResModel.data == null) {
          return Center(
            child: AdoroText(VariableUtils.noDataFound),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 10.w,
                      child: AdoroText(
                        "•",
                        textAlign: TextAlign.center,
                        fontSize: 20.sp,
                        color: ColorUtils.black92,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: AdoroText(
                          noteResModel.data?.note ?? "'N/A",
                          color: ColorUtils.black92,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ), // SizeConfig.sH3,
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.sp, 10.w, 10.sp),
                child: Container(
                  width: 80.w,
                  height: 50.w,
                  child: InkWell(
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                              // noteResModel.data?.videoUrl ?? "",
                              "https://www.youtube.com/watch?v=H5v3kku4y6Q"),
                        );
                      },
                      child: Image(
                        image: NetworkImage(noteResModel.data?.thumbnail ?? ""),
                        // image: NetworkImage(
                        //     "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                      )),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
