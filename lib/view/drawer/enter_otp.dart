import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class EnterOtpScreen extends StatelessWidget {
  const EnterOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.w),
        child: CommonAppBar(title: '', ontap: () => Get.back()),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          AdoroText(
            'Deepanshu Sarmandal',
            fontSize: 20,
            color: ColorUtils.black2E,
            fontWeight: FontWeight.w300,
          ),
          const SizedBox(
            height: 40,
          ),
          const AdoroText(
            'Enter the OTP',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: 250,
            decoration: BoxDecoration(
              color: ColorUtils.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: ColorUtils.grey, blurRadius: 3)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Stack(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*******',
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: Container(
                      height: 2,
                      width: 320,
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
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 45,
            width: 130,
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
              'Verify',
              color: ColorUtils.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
          ),
          const Spacer(),
          Container(
            height: 180,
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(165),
                    topRight: Radius.circular(165))),
            child: const Center(
                child: AdoroText(
              'adoro',
              color: ColorUtils.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            )),
          )
        ],
      ),
    );
  }
}
