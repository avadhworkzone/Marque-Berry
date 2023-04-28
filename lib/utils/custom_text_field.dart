// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';

class CommonTextFieldContainer extends StatelessWidget {
  CommonTextFieldContainer({
    Key? key,
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
    required this.controller,
    this.textAlignVertical,
  }) : super(key: key);
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
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: Theme.of(context).textTheme.titleSmall?.color,
      style: TextStyle(
        color: Theme.of(context).textTheme.titleSmall?.color,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.all(5.w),
        suffixIcon: suffixIcon,
        fillColor: color,
        hintStyle: hintStyle,
        hintText: hintText,
        // prefixIcon: prefixIcon,
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
  bool? denyInput = true;

  final String? denyInputFormatters;
  final String? allowInputFormatters;
  final TextEditingController controller;

  TextStyle? textstyle;

  FocusNode? focusNode;

  CommonTextFormField({
    Key? key,
    this.denyInput,
    this.focusNode,
    this.obscured,
    this.lableTitle,
    this.keyboardType,
    this.mobilelength,
    this.hintText,
    this.hintStyle,
    this.textstyle,
    // this.enableSuggestions,
    required this.color,
    required this.validator,
    required this.controller,
    this.denyInputFormatters,
    this.allowInputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: (v) => validator(v),
      keyboardType: keyboardType ?? TextInputType.name,
      style: textstyle ??
          TextStyle(
            color: color ?? ColorUtils.greyFA,
            fontWeight: FontWeightClass.fontWeight600,
          ),
      cursorColor: color ?? Theme.of(context).textTheme.titleSmall?.color,
      inputFormatters:
          allowInputFormatters == null || denyInputFormatters == null
              ? []
              : denyInput == false
                  ? [
                      FilteringTextInputFormatter.allow(
                        RegExp(allowInputFormatters!),
                      ),
                      FilteringTextInputFormatter.deny(
                          RegExp(denyInputFormatters!)),
                    ]
                  : [
                      FilteringTextInputFormatter.allow(
                        RegExp(allowInputFormatters!),
                      ),
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

class SearchTextFormField extends StatelessWidget {
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
  bool? denyInput = true;
  final String allowInputFormatters;
  final TextEditingController controller;

  TextStyle? textstyle;

  SearchTextFormField({
    Key? key,
    this.denyInput,
    this.obscured,
    this.lableTitle,
    this.keyboardType,
    this.mobilelength,
    this.hintText,
    this.hintStyle,
    this.textstyle,
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
      style: textstyle ??
          TextStyle(
            color: color ?? ColorUtils.greyFA,
            fontWeight: FontWeightClass.fontWeight500,
          ),
      cursorColor: color ?? Theme.of(context).textTheme.titleSmall?.color,
      inputFormatters: denyInput == false
          ? [
              FilteringTextInputFormatter.allow(RegExp(allowInputFormatters)),
              FilteringTextInputFormatter.deny(RegExp(denyInputFormatters)),
            ]
          : [
              FilteringTextInputFormatter.allow(RegExp(allowInputFormatters)),
            ],
      maxLength: mobilelength ?? 1000,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: hintText,
        hintStyle: hintStyle,
        counterText: "",
        prefixIcon: Padding(
          padding: EdgeInsets.all(2.w),
          child: InkWell(
            onTap: () {},
            child: Icon(
              Icons.search,
              color: Theme.of(context).textTheme.titleMedium?.color,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).textTheme.titleMedium?.color ??
                ColorUtils.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).textTheme.titleMedium?.color ??
                ColorUtils.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).textTheme.titleMedium?.color ??
                ColorUtils.black,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 3.w),
      ),
    );
  }

  UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide.none,
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
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        hintText: hintText,
        hintStyle: hintStyle,
      ),
    );
  }
}
