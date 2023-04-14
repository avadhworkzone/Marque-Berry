import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';

import '../../commanWidget/noInternet_screen.dart';
import '../../viewModel/connectivity_view_model.dart';

class TemplateModel {
  final String title;
  final String image;

  TemplateModel({required this.title, required this.image});
}

class Template extends StatelessWidget {
  Template({Key? key}) : super(key: key);

  List<Map<String, dynamic>> template = [
    {"title": 'Browse Template', "image": 'assets/images/browse.png'},
    {"title": 'Trending Template', "image": 'assets/images/trending.png'},
    {"title": 'Upload Template', "image": 'assets/images/upload.png'},
    {"title": 'My Template', "image": 'assets/images/my.png'}
  ];

  ConnectivityViewModel connectivityViewModel =
      Get.find<ConnectivityViewModel>();

  @override
  Widget build(BuildContext context) {
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
                    title: VariableUtils.templateText, ontap: () => Get.back()),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14.w,
                    crossAxisSpacing: 14.w,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 31.w,
                            height: 31.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/circle.png"),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(7.w),
                              child: Image.asset(
                                template[index]["image"],
                              ),
                            ),
                          ),
                          SizeConfig.sH1,
                          AdoroText(
                            template[index]["title"],
                            fontWeight: FontWeightClass.fontWeight600,
                          ),
                        ],
                      ),
                    );
                  },
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
