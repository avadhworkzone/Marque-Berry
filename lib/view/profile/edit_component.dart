// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/custom_text_field.dart';
import '../../../utils/size_config_utils.dart';
import '../../../utils/validation_utils.dart';

class EditComponent extends StatelessWidget {
  EditComponent({Key? key}) : super(key: key);
  var fullName = TextEditingController();
  var username = TextEditingController();
  var mailId = TextEditingController();
  var bankName = TextEditingController();
  var beneficiaryName = TextEditingController();
  var accountNumber = TextEditingController();
  var ifscCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 90.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.w),
        color: ColorUtils.greyFA,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeConfig.sH2,
              CommonTextFormField(
                color: ColorUtils.black,
                // color: Colors.redAccent,
                // color: blackWhite,
                controller: fullName,
                hintText: "Full Name",
                hintStyle: TextStyle(
                    color: ColorUtils.black92,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.name,
                validator: (v) => userValidation(v),
                denyInputFormatters: RegularExpression.noSpaceAllowPattern,
                allowInputFormatters: RegularExpression.nameKeyboardPattern,
              ),
              SizeConfig.sH2,
              CommonTextFormField(
                color: ColorUtils.black,
                controller: username,
                hintText: "UserName",
                hintStyle: TextStyle(
                    color: ColorUtils.black92,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.name,
                validator: (v) => userValidation(v),
                denyInputFormatters: RegularExpression.noSpaceAllowPattern,
                allowInputFormatters: RegularExpression.nameKeyboardPattern,
              ),
              SizeConfig.sH2,
              CommonTextFormField(
                color: ColorUtils.black,
                controller: mailId,
                hintText: "Mail Id",
                hintStyle: TextStyle(
                    color: ColorUtils.black92,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => userValidation(v),
                denyInputFormatters: RegularExpression.noSpaceAllowPattern,
                allowInputFormatters: RegularExpression.emailKeyboardPattern,
              ),
              SizeConfig.sH2,
              CommonTextFormField(
                color: ColorUtils.black,
                controller: bankName,
                hintText: "Bank Name",
                hintStyle: TextStyle(
                    color: ColorUtils.black92,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.name,
                validator: (v) => userValidation(v),
                denyInputFormatters: RegularExpression.noSpaceAllowPattern,
                allowInputFormatters: RegularExpression.nameKeyboardPattern,
              ),
              SizeConfig.sH2,
              CommonTextFormField(
                color: ColorUtils.black,
                controller: beneficiaryName,
                hintText: "Beneficiary Name",
                hintStyle: TextStyle(
                    color: ColorUtils.black92,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.name,
                validator: (v) => userValidation(v),
                denyInputFormatters: RegularExpression.noSpaceAllowPattern,
                allowInputFormatters: RegularExpression.nameKeyboardPattern,
              ),
              SizeConfig.sH2,
              CommonTextFormField(
                color: ColorUtils.black,
                controller: accountNumber,
                hintText: "Account Number",
                hintStyle: TextStyle(
                    color: ColorUtils.black92,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                validator: (v) => userValidation(v),
                denyInputFormatters: RegularExpression.noSpaceAllowPattern,
                allowInputFormatters: RegularExpression.contactKeyboardPattern,
              ),
              SizeConfig.sH2,
              CommonTextFormField(
                color: ColorUtils.black,
                controller: ifscCode,
                hintText: "IFSC Code",
                hintStyle: TextStyle(
                    color: ColorUtils.black92,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                validator: (v) => userValidation(v),
                denyInputFormatters: RegularExpression.noSpaceAllowPattern,
                allowInputFormatters: RegularExpression.contactKeyboardPattern,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
