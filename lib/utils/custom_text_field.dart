// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonTextFieldContainer extends StatelessWidget {
  const CommonTextFieldContainer(
      {Key? key, this.text, this.suffixIcon, this.color, this.keyboardType})
      : super(key: key);
  final Widget? suffixIcon;

  final String? text;
  final color;
  final keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5.w),
        filled: true,
        suffixIcon: suffixIcon,
        fillColor: color,
        hintText: text,
      ),
    );
  }
}
