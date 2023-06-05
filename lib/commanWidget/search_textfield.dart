import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/typedef_utils.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.onChangedString,
  });

  final OnChangedString onChangedString;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.sp),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(10.sp),
            color: ColorUtils.white,
            boxShadow: [
              BoxShadow(blurRadius: 3, color: ColorUtils.grey.shade200),
            ],
          ),
          child: TextField(
            style: TextStyle(color: ColorUtils.black),
            cursorColor: ColorUtils.black,
            onChanged: onChangedString,
            decoration: InputDecoration(
                counterText: "",
                contentPadding:
                EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorUtils.grey.shade600,
                ),
                hintText: 'Search..',
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.sp),
                    borderSide: BorderSide.none)),
            textAlign: TextAlign.start,
            maxLines: 1,
            maxLength: 20,
            // controller: _locationNameTextController,
          )),
    );
  }
}
