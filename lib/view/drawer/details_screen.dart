import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

import '../../commanWidget/common_appbar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorUtils.greyFA,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.w),
        child: CommonAppBar(title: ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              color: ColorUtils.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                    child: Image.asset('assets/images/brandName.png')),
                title: const AdoroText(
                  'Brand Name',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: const AdoroText(
                  'Time Left : XX:YY',
                  color: ColorUtils.black92,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: AdoroText(
                            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequatduis enim velit mollit...',
                            color: ColorUtils.black92,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 28.0, left: 15, right: 15),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorUtils.linearGradient1,
                          ColorUtils.linearGradient6,
                          ColorUtils.linearGradient7
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: const Center(
                    child: AdoroText(
                      'APPLY NOW',
                      color: ColorUtils.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
