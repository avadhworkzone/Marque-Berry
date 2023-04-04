import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/drawer/withdrawn_amount.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? whiteBlack = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.w),
        child: CommonAppBar(title: VariableUtils.walletText),
      ),
      body: Center(
        child: Column(
          children: [
            SizeConfig.sH3,
            AdoroText(
              'Deepanshu Sarmandal',
              fontSize: 13.sp,
            ),
            SizeConfig.sH2,
            CircleAvatar(
              radius: 15.w,
              backgroundImage: const AssetImage('assets/images/circle.png'),
              child: Image.asset('assets/images/profile.png', scale: 2.3),
            ),
            SizeConfig.sH2,
            AdoroText(
              'You have earned',
              // color: blackWhite,
              fontSize: 12.sp,
            ),
            SizeConfig.sH1,
            const AdoroText(
              '75.5C',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            SizeConfig.sH2,
            GestureDetector(
              onTap: () {
                Get.to(() => WithdrawlAmount());
              },
              child: Container(
                height: 50,
                width: 200,
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Center(
                  child: AdoroText(
                    'Withdraw Money',
                    color: ColorUtils.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizeConfig.sH2,
            const AdoroText('Withdraw Minimum limit Rs. 100 '),
            SizeConfig.sH1,
            const AdoroText('1 Cash Coin = 1 Rs '),
          ],
        ),
      ),
    );
  }
}
