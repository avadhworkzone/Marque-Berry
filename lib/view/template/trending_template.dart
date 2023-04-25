import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/trending_template_res_model.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/drawer/template.dart';
import 'package:socialv/view/template/download_template_listview.dart';
import 'package:socialv/viewModel/template_view_model.dart';

import '../../commanWidget/common_image.dart';
import '../../model/apis/api_response.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/tecell_text.dart';

class TrendingTemplate extends StatelessWidget {
  TrendingTemplate({Key? key}) : super(key: key);

  TemplateViewModel templateViewModel = Get.find<TemplateViewModel>();

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    return Scaffold(
      appBar: customAppbar(
        title: "Trending Template",
        context: context,
      ),
      body: GetBuilder<TemplateViewModel>(
        initState: (_) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await templateViewModel.trendingTemplate();
          });
        },
        builder: (templateViewModel) {
          if (templateViewModel.trendingTemplateApiResponse.status ==
                  Status.LOADING ||
              templateViewModel.trendingTemplateApiResponse.status ==
                  Status.INITIAL) {
            return Center(child: Loader());
          } else if (templateViewModel.trendingTemplateApiResponse.status ==
              Status.ERROR) {
            return Center(child: SomethingWentWrong());
          }
          final TrendingTemplateResModel trendingResponse =
              templateViewModel.trendingTemplateApiResponse.data;
          if (trendingResponse.status.toString() == VariableUtils.status500) {
            return AdoroText(trendingResponse.msg ?? "");
          }

          return Padding(
            padding: EdgeInsets.all(2.5.w),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 3.w,
                crossAxisSpacing: 3.w,
              ),
              itemCount: trendingResponse.data?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => DownloadTemplateList(
                        title: 'Trending',
                        templateList: trendingResponse.data!,
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.w),
                    child: OctoImage(
                      fit: BoxFit.cover,
                      width: 24,
                      height: 24,
                      image: NetworkImage(
                        trendingResponse.data![index].templateUrl ?? "",
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}

//tag :"(2,4)"
