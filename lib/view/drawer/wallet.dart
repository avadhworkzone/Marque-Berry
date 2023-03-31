import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar('Wallet'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const AdoroText(
              'Deepanshu Sarmandal',
              color: ColorUtils.black2E,
              fontSize: 15,
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage(
                'assets/images/circle.png',
              ),
              child: Image.asset(
                'assets/images/profile.png',
                scale: 2.3,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const AdoroText(
              'You have earned',
              color: ColorUtils.black,
              fontSize: 15,
            ),
            const SizedBox(
              height: 10,
            ),
            const AdoroText(
              '75.5C',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
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
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Center(
                  child: AdoroText(
                'Withdraw Money',
                color: ColorUtils.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            const AdoroText('Withdraw Minimum limit Rs. 100 '),
            const SizedBox(
              height: 10,
            ),
            const AdoroText('1 Cash Coin = 1 Rs '),
          ],
        ),
      ),
    );
  }
}
