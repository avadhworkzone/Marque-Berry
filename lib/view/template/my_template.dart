// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/my_template_res_model.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/viewModel/template_view_model.dart';

import '../../model/apis/api_response.dart';
import '../../utils/adoro_text.dart';
import 'download_template_listview.dart';

class MyTemplate extends StatelessWidget {
  MyTemplate({Key? key}) : super(key: key);

  // MyTemplateController myTemplateController = Get.find<MyTemplateController>();

  TemplateViewModel templateViewModel = Get.find<TemplateViewModel>();
  List<Standard> templateList = [];

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: customAppbar(title: "My Template", context: context),
        body: GetBuilder<TemplateViewModel>(
          initState: (_) async {
            // myTemplateController._showLoader = true;
            await templateViewModel.myTemplate();
            if (templateViewModel.myTemplateApiResponse.status ==
                Status.COMPLETE) {
              final MyTemplateResModel trendingResponse =
                  templateViewModel.myTemplateApiResponse.data;

              if (trendingResponse.status == 500) {
                // myTemplateController._showLoader = false;
              } else {
                for (int i = 0;
                    i < (trendingResponse.data?.standard?.length ?? 0);
                    i++) {
                  templateList.addAll(trendingResponse.data!.standard!);
                }
                await Future.delayed(Duration(seconds: 1));
                for (int i = 0;
                    i < (trendingResponse.data?.licensed?.length ?? 0);
                    i++) {
                  templateList.addAll(trendingResponse.data!.licensed!);
                }
              }
            }
            // myTemplateController._showLoader = false;
          },
          builder: (templateViewModel) {
            if (templateViewModel.myTemplateApiResponse.status ==
                    Status.LOADING ||
                // myTemplateController._showLoader == true ||
                templateViewModel.myTemplateApiResponse.status ==
                    Status.INITIAL) {
              return Center(child: Loader());
            } else if (templateViewModel.myTemplateApiResponse.status ==
                Status.ERROR) {
              return Center(child: SomethingWentWrong());
            }
            final MyTemplateResModel trendingResponse =
                templateViewModel.myTemplateApiResponse.data;

            if (trendingResponse.status.toString() == VariableUtils.status500) {
              return Center(child: AdoroText(trendingResponse.msg ?? ""));
            }

            return Padding(
              padding: EdgeInsets.fromLTRB(2.5.w, 0, 2.5.w, 2.5.w),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3.w,
                  crossAxisSpacing: 3.w,
                ),
                padding: EdgeInsets.zero,
                itemCount: trendingResponse.data?.standard?.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => DownloadTemplateList(
                          title: 'My Template',
                          index: index,
                          templateList: templateList,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1.5.w),
                      child: OctoImage(
                        fit: BoxFit.cover,
                        width: 24,
                        height: 24,
                        image: NetworkImage(
                          templateList[index].templateUrl ?? "",
                        ),
                        // fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, progress) {
                          double? value;
                          var expectedBytes = progress?.expectedTotalBytes;
                          if (progress != null && expectedBytes != null) {
                            value =
                                progress.cumulativeBytesLoaded / expectedBytes;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: value,
                              color: blackWhite,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stacktrace) => Container(
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
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(2.w),
                    //   child: Image.network(
                    //     templateList[index].templateUrl ?? "",
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                  );
                },
              ),
            );
          },
        ));
  }
}

// class MyTemplateController extends GetxController {
//   bool _showLoader = false;
//   bool get showLoader => _showLoader;
//
//   set showLoader(bool value) {
//     _showLoader = value;
//     update();
//   }
// }
