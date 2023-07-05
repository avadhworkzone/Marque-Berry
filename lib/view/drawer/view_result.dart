import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/size_config_utils.dart';

import '../../commanWidget/common_appbar.dart';
import '../../commanWidget/loader.dart';
import '../../model/apiModel/responseModel/result_campaign_res_model.dart';
import '../../utils/adoro_text.dart';
import '../../utils/color_utils.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/variable_utils.dart';
import '../../viewModel/drawer_viewmodel.dart';

class ViewResult extends StatelessWidget {
  ViewResult({
    required this.resultType,
    Key? key,
  }) : super(key: key);

  final String resultType;

  final DrawerVideModel drawerVideModel = Get.find<DrawerVideModel>();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    return Scaffold(
      // backgroundColor: whiteBlack2E,
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(16.w),
        child: CommonAppBar(
          title: VariableUtils.viewResult,
          onTap: () => Get.back(),
        ),
      ),
      body: GetBuilder<DrawerVideModel>(
        builder: (controller) {
          if (controller.getResultCampaignResponse.status == Status.LOADING ||
              controller.getResultCampaignResponse.status == Status.INITIAL) {
            return Center(child: Loader());
          } else if (controller.getResultCampaignResponse.status ==
              Status.ERROR) {
            return Center(child: SomethingWentWrong());
          }
          final ResultCampaignResModel resultCampaignResModel =
              controller.getResultCampaignResponse.data;

          if (resultCampaignResModel.status != 200) {
            return Center(
              child: AdoroText(VariableUtils.noDataFound),
            );
          }
          final viewResultList = resultCampaignResModel.data;

          return ListView.builder(
            itemCount: viewResultList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    SizeConfig.sH2,
                    Container(
                      height: 6.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: whiteBlack2E,
                          boxShadow: [
                            BoxShadow(blurRadius: 2, color: Colors.grey),
                          ],
                          borderRadius: BorderRadius.circular(4.w)),
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 30,
                            child: Text("${index + 1}.",
                                style: TextStyle(
                                    color: ColorUtils.black92,
                                    fontSize: 15.sp)),
                          ),
                          Expanded(
                            child: AdoroText(
                              viewResultList[index].username ?? "",
                              // VariableUtils.userName,
                              fontSize: 13.sp,
                              fontWeight: FontWeightClass.fontWeightBold,
                              color: blackWhite,
                            ),
                          ),
                          resultType == 'campaign'
                              ? AdoroText(
                                  viewResultList[index].wonAmount.toString(),
                                  // VariableUtils.price,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeightClass.fontWeightBold,
                                  color: ColorUtils.green4E,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    viewResultList[index].image ?? "",
                                    scale: 2,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress != null) {
                                        return CupertinoActivityIndicator();
                                      }
                                      return child;
                                    },
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
