import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/custom_btn.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/controllers/intrest_controller.dart';
import 'package:socialv/model/apiModel/responseModel/meme_res_model.dart';

class InterestScreen extends StatelessWidget {
  InterestScreen({Key? key}) : super(key: key);

  AuthViewModel authViewModel = Get.find<AuthViewModel>();
  InterestController interestController = Get.find<InterestController>();

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GetBuilder<AuthViewModel>(builder: (authViewModel) {
        return GetBuilder<InterestController>(
          init: InterestController(),
          initState: (_) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
              await interestController.memeCategoryApiCall();
            });
          },
          builder: (interestController) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeConfig.sH10,
                  AdoroText(
                    VariableUtils.welcomeToAdoro,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: blackWhite,
                  ),
                  AdoroText(
                    VariableUtils.chooseOrMoreMemeCategories,
                    color: blackWhite,
                  ),
                  SizeConfig.sH2,
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: 18,
                      itemBuilder: (BuildContext context, int index) {
                        if (authViewModel.memeCategoryApiResponse.status ==
                                Status.LOADING ||
                            authViewModel.memeCategoryApiResponse.status ==
                                Status.INITIAL)
                          return CircularProgressIndicator();
                        else if (authViewModel.memeCategoryApiResponse.status ==
                                Status.ERROR ||
                            authViewModel.memeCategoryApiResponse.data == null)
                          return Center(
                            child: AdoroText(
                              VariableUtils.somethingWentWrong,
                            ),
                          );
                        else if (authViewModel.memeCategoryApiResponse.status ==
                            Status.COMPLETE) {
                          MemeCategoryResModel memeResponse =
                              authViewModel.memeCategoryApiResponse.data;
                          return InkWell(
                            onTap: interestController.tempCategoryIndex.length <
                                        3 ||
                                    interestController.tempCategoryIndex
                                            .contains(memeResponse
                                                .data?[index].title
                                                .toString()) ==
                                        true
                                ? () {
                                    interestController.addIndex(
                                      memeResponse.data?[index].id.toString() ??
                                          "",
                                      memeResponse.data?[index].title ?? "",
                                    );
                                  }
                                : null,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2.w),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    height: 15.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "${memeResponse.data?[index].imageUrl ?? ""}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        OctoImage(
                                          image: NetworkImage(
                                            "${memeResponse.data?[index].imageUrl ?? ""}",
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
                                            return Padding(
                                              padding: EdgeInsets.all(8.w),
                                              child: CircularProgressIndicator(
                                                value: value,
                                                color: blackWhite,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stacktrace) =>
                                                  Padding(
                                            padding: EdgeInsets.all(7.w),
                                            child: CommonImage(
                                              img: IconsWidgets
                                                  .imageNotFoundImages,
                                              color: blackWhite,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                AdoroText(
                                                  "${memeResponse.data?[index].title ?? ""}",
                                                  color: blackWhite,
                                                  fontWeight: FontWeightClass
                                                      .fontWeightBold,
                                                ),
                                              ],
                                            ),
                                            // SizeConfig.sH05,
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                if (interestController.tempCategoryIndex
                                        .contains(
                                      memeResponse.data?[index].title,
                                    ) ==
                                    true)
                                  Container(
                                    height: 2.5.h,
                                    width: 5.w,
                                    decoration:
                                        DecorationUtils.welcomeDecoration(
                                            context),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/design.png"),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizeConfig.sH2,
                  Center(
                    child: interestController.selectedCategoryList.length == 3
                        ? CustomBtn(
                            onTap: () async {
                              await interestController.setPreference();
                              await PreferenceUtils.setWelcome(1);
                              Get.offAllNamed(RouteHelper.getBottomRoute());
                            },
                            text: 'DONE',
                          )
                        : CustomBtn(
                            onTap: null,
                            text: 'DONE',
                            decoration: BoxDecoration(
                              color: ColorUtils.black92,
                              borderRadius: BorderRadius.circular(1.5.w),
                            ),
                          ),
                  ),
                  SizeConfig.sH2,
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
