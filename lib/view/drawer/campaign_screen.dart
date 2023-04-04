import 'package:flutter/material.dart';
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
    padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
    child: Container(
      height: 230,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ListTile(
            leading:
                CircleAvatar(child: Image.asset('assets/images/brandName.png')),
            title: AdoroText(
              title,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            subtitle: const AdoroText(
              'Time Left : XX:YY',
              color: ColorUtils.black92,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: AdoroText(
              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit...',
              color: ColorUtils.black92,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
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
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15),
            child: Container(
              height: 40,
              width: size.width,
              decoration: const BoxDecoration(
                  color: ColorUtils.greyFA,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: const Center(
                child: AdoroText(
                  'KNOW MORE',
                  color: ColorUtils.black92,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
