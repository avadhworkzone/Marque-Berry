import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class CampaignScreen extends StatelessWidget {
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? whiteBlue = Theme.of(context).scaffoldBackgroundColor;
    Color? whiteBlack = Theme.of(context).textTheme.titleSmall?.color;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: whiteBlue,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: whiteBlue,
          leading: Container(
            width: 10.w,
            child: Icon(Icons.arrow_back, color: whiteBlack),
          ),
          title: const TabBar(
            labelColor: ColorUtils.blueB9,
            indicatorColor: ColorUtils.blueB9,
            unselectedLabelColor: ColorUtils.black92,
            tabs: [
              Tab(
                child: AdoroText(
                  'Campaign',
                  color: ColorUtils.blueB9,
                  fontWeight: FontWeightClass.fontWeight600,
                ),
              ),
              Tab(
                child: AdoroText(
                  'Contest',
                  // color: ColorUtils.blueB9,
                  fontWeight: FontWeightClass.fontWeight600,
                ),
              ),
            ],
          ),
          actions: [SizeConfig.sW4],
        ),
        body: const TabBarView(
          children: [
            CampaignScn(),
            ContestScreen(),
          ],
        ),
      ),
    );
  }
}

///Campaign Screen
class CampaignScn extends StatelessWidget {
  const CampaignScn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return tabbarMethod(size, title: 'Brand Name');
      },
    );
  }
}

///Contest Screen
class ContestScreen extends StatelessWidget {
  const ContestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return tabbarMethod(size, title: 'contest Name');
      },
    );
  }
}

Padding tabbarMethod(Size size, {required String title}) {
  return Padding(
    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.w),
    child: Container(
      margin: EdgeInsets.only(bottom: 2.w),
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                child: Image.asset('assets/images/Profile1.png'),
              ),
              title: AdoroText(
                title,
                fontSize: 12.sp,
                color: ColorUtils.black,
                fontWeight: FontWeight.bold,
              ),
              subtitle: const AdoroText(
                'Time Left : XX:YY',
                color: ColorUtils.black92,
              ),
            ),
            AdoroText(
              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit...',
              color: ColorUtils.black92,
            ),
            Container(
              height: 5.h,
              width: size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorUtils.linearGradient1,
                      ColorUtils.linearGradient6,
                      ColorUtils.linearGradient7
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(3.w))),
              child: Center(
                child: AdoroText(
                  'APPLY NOW',
                  color: ColorUtils.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Container(
              height: 40,
              width: size.width,
              decoration: BoxDecoration(
                  color: ColorUtils.greyFA,
                  borderRadius: BorderRadius.all(Radius.circular(3.w))),
              child: Center(
                child: AdoroText(
                  'KNOW MORE',
                  color: ColorUtils.black92,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
