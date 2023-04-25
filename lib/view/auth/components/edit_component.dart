// // ignore_for_file: must_be_immutable
//
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:socialv/model/apiModel/responseModel/get_user_res_model.dart';
// import 'package:socialv/utils/font_style_utils.dart';
//
// import '../../../utils/color_utils.dart';
// import '../../../utils/custom_text_field.dart';
// import '../../../utils/size_config_utils.dart';
// import '../../../utils/validation_utils.dart';
//
// class EditComponent extends StatelessWidget {
//   GetUserResDetail response;
//
//   EditComponent({Key? key, required this.response}) : super(key: key);
//   // var fullName = TextEditingController(text: response.data?[0].fullName ?? "");
//   // var username = TextEditingController();
//   // var mailId = TextEditingController();
//   // var bankName = TextEditingController();
//   // var beneficiaryName = TextEditingController();
//   // var accountNumber = TextEditingController();
//   // var ifscCode = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     var profileData = response.data?[0];
//     var coverPhoto = profileData?.coverPhoto;
//     var fullName = TextEditingController(text: profileData?.fullName ?? "");
//
//     var username = TextEditingController(text: profileData?.username ?? "");
//     var mailId = TextEditingController(text: profileData?.email ?? "");
//     var bankName = TextEditingController(text: profileData?.bankName ?? "");
//     var beneficiaryName =
//         TextEditingController(text: profileData?.beneficiaryName ?? "");
//     var accountNumber =
//         TextEditingController(text: profileData?.accountNumber ?? "");
//     var ifscCode = TextEditingController(text: profileData?.ifscCode ?? "");
//
//     Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
//     Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
//     return Container(
//       width: 90.w,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4.w),
//         color: ColorUtils.greyFA,
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 2.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizeConfig.sH2,
//               CommonTextFormField(
//                 color: ColorUtils.black,
//                 controller: fullName,
//                 hintText: "Full Name",
//                 hintStyle: FontTextStyle.profileText,
//                 textstyle: FontTextStyle.profileText
//                     .copyWith(color: ColorUtils.black92),
//                 keyboardType: TextInputType.name,
//                 validator: (v) => userValidation(v),
//                 denyInputFormatters: RegularExpression.noSpaceAllowPattern,
//                 allowInputFormatters: RegularExpression.nameKeyboardPattern,
//               ),
//               SizeConfig.sH2,
//               CommonTextFormField(
//                 color: ColorUtils.black,
//                 controller: username,
//                 hintText: "UserName",
//                 hintStyle: FontTextStyle.profileText,
//                 textstyle: FontTextStyle.profileText
//                     .copyWith(color: ColorUtils.black92),
//                 keyboardType: TextInputType.name,
//                 validator: (v) => userValidation(v),
//                 denyInputFormatters: RegularExpression.noSpaceAllowPattern,
//                 allowInputFormatters: RegularExpression.nameKeyboardPattern,
//               ),
//               SizeConfig.sH2,
//               CommonTextFormField(
//                 color: ColorUtils.black,
//                 controller: mailId,
//                 hintText: "Mail Id",
//                 hintStyle: FontTextStyle.profileText,
//                 textstyle: FontTextStyle.profileText
//                     .copyWith(color: ColorUtils.black92),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (v) => userValidation(v),
//                 denyInputFormatters: RegularExpression.noSpaceAllowPattern,
//                 allowInputFormatters: RegularExpression.emailKeyboardPattern,
//               ),
//               SizeConfig.sH2,
//               CommonTextFormField(
//                 color: ColorUtils.black,
//                 controller: bankName,
//                 hintText: "Bank Name",
//                 hintStyle: FontTextStyle.profileText,
//                 textstyle: FontTextStyle.profileText
//                     .copyWith(color: ColorUtils.black92),
//                 keyboardType: TextInputType.name,
//                 validator: (v) => userValidation(v),
//                 denyInputFormatters: RegularExpression.noSpaceAllowPattern,
//                 allowInputFormatters: RegularExpression.nameKeyboardPattern,
//               ),
//               SizeConfig.sH2,
//               CommonTextFormField(
//                 color: ColorUtils.black,
//                 controller: beneficiaryName,
//                 hintText: "Beneficiary Name",
//                 hintStyle: FontTextStyle.profileText,
//                 textstyle: FontTextStyle.profileText
//                     .copyWith(color: ColorUtils.black92),
//                 keyboardType: TextInputType.name,
//                 validator: (v) => userValidation(v),
//                 denyInputFormatters: RegularExpression.noSpaceAllowPattern,
//                 allowInputFormatters: RegularExpression.nameKeyboardPattern,
//               ),
//               SizeConfig.sH2,
//               CommonTextFormField(
//                 color: ColorUtils.black,
//                 controller: accountNumber,
//                 hintText: "Account Number",
//                 hintStyle: FontTextStyle.profileText,
//                 textstyle: FontTextStyle.profileText
//                     .copyWith(color: ColorUtils.black92),
//                 keyboardType: TextInputType.number,
//                 validator: (v) => userValidation(v),
//                 denyInputFormatters: RegularExpression.noSpaceAllowPattern,
//                 allowInputFormatters: RegularExpression.contactKeyboardPattern,
//               ),
//               SizeConfig.sH2,
//               CommonTextFormField(
//                 color: ColorUtils.black,
//                 controller: ifscCode,
//                 hintText: "IFSC Code",
//                 hintStyle: FontTextStyle.profileText,
//                 textstyle: FontTextStyle.profileText
//                     .copyWith(color: ColorUtils.black92),
//                 keyboardType: TextInputType.number,
//                 validator: (v) => userValidation(v),
//                 denyInputFormatters: RegularExpression.noSpaceAllowPattern,
//                 allowInputFormatters: RegularExpression.contactKeyboardPattern,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
