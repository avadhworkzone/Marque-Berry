import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class CampaignScreen extends StatelessWidget {
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorUtils.note,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorUtils.greyFA,
          leading: const Icon(
            Icons.arrow_back,
            color: ColorUtils.black,
          ),
          title: const TabBar(
            labelColor: ColorUtils.blueB9,
            unselectedLabelColor: ColorUtils.black92,
            tabs: [
              Tab(
                  child: Text(
                'Campaign',
              )),
              Tab(
                  child: Text(
                'Contest',
              )),
            ],
          ),
        ),
        body: const TabBarView(
          children: [CampaignScn(), ContestScreen()],
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
        });
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
        });
  }
}

Padding tabbarMethod(Size size, {required String title}) {
  return Padding(
    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.w),
    child: Container(
      height: 31.h,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: Column(
        children: [
          ListTile(
            leading:
                CircleAvatar(child: Image.asset('assets/images/Profile1.png')),
            title: AdoroText(
              title,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
            subtitle: const AdoroText(
              'Time Left : XX:YY',
              color: ColorUtils.black92,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: AdoroText(
              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit...',
              color: ColorUtils.black92,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 4.w),
            child: Container(
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
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w, top: 4.w, right: 5.w),
            child: Container(
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
          ),
        ],
      ),
    ),
  );
}
