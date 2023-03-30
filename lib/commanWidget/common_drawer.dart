import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/typedef_utils.dart';

import '../utils/tecell_text.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    child: Icon(Icons.arrow_back),
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 10.w,
                  backgroundColor: Colors.grey[400],
                  backgroundImage: AssetImage("assets/images/"),
                ),
                title: AdoroText(
                  "Deepanshu Sarmandal",
                  fontWeight: FontWeightClass.fontWeight600,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: AdoroText(
                    "@deepanshu",
                    fontWeight: FontWeightClass.fontWeight500,
                  ),
                ),
              ),
              drawerData(
                title: 'Notification',
                image: 'assets/icons/notification.png',
                onTap: () {},
              ),
              drawerData(
                title: 'Result',
                image: 'assets/icons/result.png',
                onTap: () {},
              ),
              drawerData(
                title: 'Note from adoro',
                image: 'assets/icons/note.png',
                onTap: () {},
              ),
              drawerData(
                title: 'Wallet',
                image: 'assets/icons/wallet.png',
                onTap: () {},
              ),
              drawerData(
                title: 'Template',
                image: 'assets/icons/template.png',
                onTap: () {},
              ),
              drawerData(
                title: 'Refer & Earn',
                image: 'assets/icons/refer.png',
                onTap: () {},
              ),
              drawerData(
                title: 'Support',
                image: 'assets/icons/support.png',
                onTap: () {},
              ),
              drawerData(
                title: 'Settings',
                image: 'assets/icons/setting.png',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerData({
    required OnTab onTap,
    required String image,
    required String title,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(3.w, 0.5.w, 3.w, 0),
      child: ListTile(
        leading: Image.asset(
          image,
          fit: BoxFit.cover,
          width: 5.5.w,
        ),
        minLeadingWidth: 5.w,
        title: AdoroText(
          title,
          color: ColorUtils.black2E,
          fontWeight: FontWeightClass.fontWeight600,
        ),
        onTap: onTap,
      ),
    );
  }
}
