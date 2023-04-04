// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';

class CommonTextFieldContainer extends StatelessWidget {
  const CommonTextFieldContainer(
      {Key? key,
      this.text,
      this.suffixIcon,
      this.color,
      this.keyboardType,
      this.prefixIcon,
      this.minLines,
      this.maxLines,
      this.hintStyle,
      this.hintText,
      this.decoration,
      this.textAlignVertical})
      : super(key: key);
  final Widget? suffixIcon;

  final text;
  final color;
  final keyboardType;
  final prefixIcon;
  final minLines;
  final maxLines;
  final hintStyle;
  final hintText;
  final textAlignVertical;
  final decoration;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      textAlignVertical: textAlignVertical,
      decoration: InputDecoration(
        // filled: true,

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorUtils.greyFA),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorUtils.greyFA),
        ),
        contentPadding: EdgeInsets.zero,
        suffixIcon: suffixIcon,
        fillColor: color,
        hintStyle: hintStyle,
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
    );
  }
}

class CommonTextFormField extends StatelessWidget {
  final bool? obscured;
  final String? lableTitle;
  final int? mobilelength;
  final Color? color;
  final Function validator;
  final hintText;
  final hintStyle;
  // final bool? enableSuggestions;
  final TextInputType? keyboardType;
  final String denyInputFormatters;
  final String allowInputFormatters;
  final TextEditingController controller;

  CommonTextFormField({
    Key? key,
    this.obscured,
    this.lableTitle,
    this.keyboardType,
    this.mobilelength,
    this.hintText,
    this.hintStyle,
    // this.enableSuggestions,
    required this.color,
    required this.validator,
    required this.controller,
    required this.denyInputFormatters,
    required this.allowInputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (v) => validator(v),
      keyboardType: keyboardType ?? TextInputType.name,
      style: TextStyle(
        color: color ?? ColorUtils.greyFA,
        fontWeight: FontWeightClass.fontWeight500,
      ),
      cursorColor: Theme.of(context).textTheme.titleSmall?.color,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(allowInputFormatters)),
        FilteringTextInputFormatter.deny(RegExp(denyInputFormatters)),
      ],
      maxLength: mobilelength ?? 1000,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: hintStyle,
        fillColor: ColorUtils.transparent,
        counterText: "",
        border: underlineInputBorder,
        focusedBorder: underlineInputBorder,
        enabledBorder: underlineInputBorder,
        contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
      ),
    );
  }

  UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: ColorUtils.grey.withOpacity(0.5)),
  );
}

class EditTextFormField extends StatelessWidget {
  final hintText;
  final hintStyle;

  const EditTextFormField({super.key, this.hintText, this.hintStyle});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintText: hintText,
          hintStyle: hintStyle),
    );
  }
}
