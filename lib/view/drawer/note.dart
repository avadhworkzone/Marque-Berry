// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

import '../../commanWidget/noInternet_screen.dart';
import '../../utils/variable_utils.dart';
import '../../viewModel/connectivity_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Note extends StatelessWidget {
  Note({
    Key? key,
  }) : super(key: key);

  ConnectivityViewModel connectivityViewModel =
      Get.find<ConnectivityViewModel>();

  @override
  Widget build(BuildContext context) {
    return _bulidBody();
  }

  GetBuilder<ConnectivityViewModel> _bulidBody() {
    return GetBuilder<ConnectivityViewModel>(
      init: ConnectivityViewModel(),
      initState: (_) {
        connectivityViewModel.startMonitoring();
      },
      builder: (connectivityViewModel) {
        if (connectivityViewModel.isOnline != null) {
          if (connectivityViewModel.isOnline!) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(16.w),
                child: CommonAppBar(
                    title: VariableUtils.note, onTap: () => Get.back()),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
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
                              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. ',
                              color: ColorUtils.black92,
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                      ],
                    ), // SizeConfig.sH3,
                    Container(
                      width: 85.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 3.w,
                        ),
                        child: Container(
                          height: 22.h,
                          width: 70.w,
                          // color: ColorUtils.note,

                          child: InkWell(
                              onTap: () {
                                launchUrl(
                                  Uri.parse(
                                      'https://www.youtube.com/watch?v=4xl9KfUg8Lc'),
                                );
                              },
                              child: Image(
                                image: NetworkImage(
                                    'https://www.bollywoodhungama.com/wp-content/uploads/2022/11/Pathaan-5.jpg'),
                                fit: BoxFit.fill,
                              )
                              // Image.asset(
                              //   'assets/images/playmusic.png',
                              //   scale: 0.5.w,
                              // ),
                              ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const NoInterNetConnected();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
