import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
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
  final List<TemplateModel> templateList = [
    TemplateModel(title: 'Browse Template', image: 'assets/images/browse.png'),
    TemplateModel(
        title: 'Treading Template', image: 'assets/images/trending.png'),
    TemplateModel(title: 'Upload Template', image: 'assets/images/upload.png'),
    TemplateModel(title: 'My Template', image: 'assets/images/my.png')
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
                child: CommonAppBar(title: VariableUtils.templateText),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: templateList
                      .map(
                        (e) => Column(
                          children: [
                            Spacer(),
                            CircleAvatar(
                              radius: 16.w,
                              backgroundImage: const AssetImage(
                                'assets/images/background.png',
                              ),
                              child: Image.asset(e.image, scale: 0.4.w),
                            ),
                            Spacer(),
                            AdoroText(e.title),
                          ],
                        ),
                      )
                      .toList(),
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
