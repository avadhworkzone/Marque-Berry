import 'dart:developer';
import 'package:flutter/foundation.dart';

class ConstUtils {}

logs(String message) {
  if (kDebugMode) {
    log(message);
  }
}

String postTimeCalculate(date) {
  DateTime date1 = DateTime.parse(date);
  DateTime date2 = DateTime.now();

  int data = date2.difference(date1).inDays;
  if (date2.difference(date1).inSeconds < 60) {
    return "$data sec ago";
  } else if (date2.difference(date1).inMinutes < 60) {
    return "$data min ago";
  } else if (date2.difference(date1).inHours < 60) {
    return "$data h ago";
  } else if (date2.difference(date1).inDays < 8) {
    return "$data d ago";
  } else {
    return "${(data / 7).toStringAsFixed(0)} w ago";
  }
}
