import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class ReferAndEarn extends StatelessWidget {
  const ReferAndEarn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppbar('Refer & Earn'),
      body: Column(children: [
        Stack(
          children: [
            Container(
              height: size.height / 3.4,
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
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(bottom: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  AdoroText(
                    'Refer & Earn',
                    color: ColorUtils.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 25,
              right: 25,
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorUtils.black2E),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 5)),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0, right: 18),
                      child: AdoroText(
                          'Copy the link below & share it with your friends',
                          textAlign: TextAlign.center),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 45,
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorUtils.referEarn,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          // Image.asset(
                          //   'assets/images/InterfaceLink.png',
                          //   scale: 15,
                          // ),
                          Icon(Icons.link),
                          AdoroText('https://www.webhood.net/'),
                          Icon(Icons.shopping_bag_outlined)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 50,
          width: 150,
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
            'Share',
            color: ColorUtils.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )),
        ),
        const SizedBox(
          height: 50,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30),
          child: AdoroText(
            'When your friends will download the app with the referal code, you will get instant Rs. 2 in your wallet .'
            ' And when your friend earn its first earning , then you will also get 5% from there first earning',
            fontSize: 15,
            textAlign: TextAlign.center,
          ),
        )
      ]),
    );
  }
}