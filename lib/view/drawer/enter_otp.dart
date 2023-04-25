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
          SizedBox(
            height: 20.h,
          ),
          AdoroText(
            'Deepanshu Sarmandal',
            fontSize: 13.sp,
            color: ColorUtils.black2E,
            fontWeight: FontWeight.w300,
          ),
          SizedBox(
            height: 5.h,
          ),
          AdoroText(
            'Enter the OTP',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            height: 11.h,
            width: 75.w,
            decoration: BoxDecoration(
              color: ColorUtils.white,
              borderRadius: BorderRadius.circular(6.w),
              boxShadow: [BoxShadow(color: ColorUtils.grey, blurRadius: 2.w)],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.w),
              child: Stack(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '*******',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  Positioned(
                    top: 10.w,
                    child: Container(
                      height: 0.3.h,
                      width: 65.w,
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
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.w),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.w,
          ),
          Container(
            height: 4.h,
            width: 23.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/Rectangle.png",
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(5.w))),
            child: Center(
                child: AdoroText(
              'Verify',
              color: ColorUtils.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
            )),
          ),
          const Spacer(),
          Container(
            height: 20.h,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/Ellipse.png",
                    ),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.w),
                    topRight: Radius.circular(10.w))),
            child: Center(
                child: AdoroText(
              'adoro',
              color: ColorUtils.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            )),
          )
        ],
      ),
    );
  }
}
