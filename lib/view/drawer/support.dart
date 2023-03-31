import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppbar('Support'),
      body: Column(children: [
        Stack(
          children: [
            Container(
              height: size.height / 2.3,
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
              margin: const EdgeInsets.only(bottom: 240),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    AdoroText('Hi,Cheon Yeo Woon',
                        fontSize: 20,
                        color: ColorUtils.white,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 20,
                    ),
                    AdoroText(
                        'Please fill this from,our team will reach out to you soon',
                        fontSize: 17,
                        color: ColorUtils.white,
                        fontWeight: FontWeight.bold),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 25,
              right: 25,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ColorUtils.linearGradient5),
                    color: Colors.white),
                height: 350,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Fullname',
                            hintStyle: TextStyle(color: ColorUtils.black92)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'E-mail',
                            hintStyle: TextStyle(color: ColorUtils.black92)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 150,
                        width: 200,
                        decoration: BoxDecoration(
                            color: ColorUtils.white,
                            border:
                                Border.all(color: ColorUtils.linearGradient5)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AdoroText('Your Message',
                              color: ColorUtils.black92),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  ColorUtils.linearGradient1,
                  ColorUtils.linearGradient6,
                  ColorUtils.linearGradient7,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(30),
                color: ColorUtils.linearGradient6),
            child: const Center(
              child: AdoroText('Submit',
                  fontSize: 17,
                  color: ColorUtils.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ]),
    );
  }
}
