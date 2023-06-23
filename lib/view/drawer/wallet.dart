// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/get_wallet_balance_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/view/drawer/withdrawn_amount.dart';
import 'package:socialv/viewModel/drawer_viewmodel.dart';

import '../../commanWidget/noInternet_screen.dart';
import '../../utils/assets/images_utils.dart';
import '../../viewModel/connectivity_view_model.dart';

class Wallet extends StatelessWidget {
  Wallet({Key? key}) : super(key: key);
  DrawerVideModel videModel = Get.find<DrawerVideModel>();

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    final fullName = PreferenceUtils.getString(key: PreferenceUtils.fullname);
    final userName = PreferenceUtils.getString(key: PreferenceUtils.username);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(16.w),
        child: CommonAppBar(
          title: VariableUtils.walletText,
          onTap: () => Get.back(),
        ),
      ),
      body: GetBuilder<DrawerVideModel>(
        initState: (_) {
          videModel.getWalletBalance();
        },
        builder: (con) {
          if (con.getWalletBalanceApiResponse.status == Status.LOADING ||
              con.getWalletBalanceApiResponse.status == Status.INITIAL) {
            return Center(child: Loader());
          } else if (con.getWalletBalanceApiResponse.status == Status.ERROR) {
            return Center(child: SomethingWentWrong());
          }
          final GetWalletBalanceResModel walletResModel =
              con.getWalletBalanceApiResponse.data;
          if (walletResModel.status != 200) {
            return Center(
              child: AdoroText(VariableUtils.noDataFound),
            );
          }
          final balanceList = walletResModel.data
              ?.map((e) => num.parse(e.balance ?? "0"))
              .toList();

          return SizedBox(
            width: Get.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizeConfig.sH7,
                  AdoroText(
                    fullName == null || fullName == "" ? userName : fullName,
                    fontSize: 20.sp,
                  ),
                  SizeConfig.sH3,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                          width: 30.w,
                          height: 30.w,
                          image: AssetImage(
                            ImagesWidgets.circleImage,
                          )),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.w),
                        child: Container(
                          color: Colors.grey[200],
                          child: OctoImage(
                            fit: BoxFit.cover,
                            width: 27.w,
                            height: 27.w,
                            image: NetworkImage(
                              PreferenceUtils.getString(
                                  key: PreferenceUtils.profileImage),
                            ),
                            progressIndicatorBuilder: (context, progress) {
                              double? value;
                              var expectedBytes = progress?.expectedTotalBytes;
                              if (progress != null && expectedBytes != null) {
                                value = progress.cumulativeBytesLoaded /
                                    expectedBytes;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: value,
                                  color: blackWhite,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stacktrace) =>
                                Padding(
                              padding: EdgeInsets.all(2.w),
                              child: CommonImage(
                                img: IconsWidgets.userImages,
                                color: ColorUtils.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*  CircleAvatar(
                    radius: 15.w,
                    child: Stack(
                      children: [
                        Image(
                            image: AssetImage(
                          ImagesWidgets.circleImage,
                        )),
                        // ImagesWidgets.circleImage,
                        Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Center(
                            // child: Image.asset(
                            //   ImagesWidgets.profile2Image,
                            // ),
                            child: Image.network(
                              PreferenceUtils.getString(
                                  key: PreferenceUtils.profileImage),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress != null) {
                                  return CupertinoActivityIndicator();
                                }
                                return child;
                              },
                              errorBuilder: (context, error, stackTrace) => Image.asset(IconsWidgets.userImages),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),*/
                  SizeConfig.sH2,
                  AdoroText(
                    VariableUtils.youHaveEarned,
                    color: blackWhite,
                    fontWeight: FontWeight.w400,
                    // color: blackWhite,
                    fontSize: 15.sp,
                  ),
                  SizeConfig.sH1,
                  AdoroText(
                    // VariableUtils.wallet75,
                    '${balanceList!.reduce((value, element) => value + element)} C',
                    color: blackWhite,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  // SizeConfig.sH2,
                  InkWell(
                    splashColor: ColorUtils.transparent,
                    highlightColor: ColorUtils.transparent,
                    onTap: () => Get.to(WithdrawnAmount()),
                    child: Container(
                      height: 18.w,
                      width: 55.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                        ImagesWidgets.rectangleImage,
                      ))),
                      child: Center(
                        child: AdoroText(
                          VariableUtils.withdrawMoney,
                          fontSize: 17.sp,
                          color: ColorUtils.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizeConfig.sH3,
                  AdoroText(
                    VariableUtils.withdrawMinimumLimit,
                    color: blackWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                  SizeConfig.sH1,
                  AdoroText(
                    VariableUtils.cashCoin,
                    color: blackWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
