import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.w),
        child: CommonAppBar(title: VariableUtils.templateText),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      radius: 55,
                      backgroundImage: const AssetImage(
                        'assets/images/background.png',
                      ),
                      child: Image.asset(e.image, scale: 1.9),
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
  }
}
