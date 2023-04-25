import 'dart:developer';
import 'package:flutter/foundation.dart';

class ConstUtils {}

logs(String message) {
  if (kDebugMode) {
    log(message);
  }
}

List<Category> categoryDataList = [];

String postTimeCalculate(date, ext) {
  try {
    if (date != "") {
      DateTime date1 = DateTime.parse(date);
      DateTime date2 = DateTime.now();

      int data = date2.difference(date1).inDays;
      if (date2.difference(date1).inSeconds < 60) {
        return "$data sec $ext";
      } else if (date2.difference(date1).inMinutes < 60) {
        return "$data min $ext";
      } else if (date2.difference(date1).inHours < 60) {
        return "$data h $ext";
      } else if (date2.difference(date1).inDays < 8) {
        return "$data d $ext";
      } else {
        return "${(data / 7).toStringAsFixed(0)} w $ext";
      }
    } else {
      return '';
    }
  } catch (e) {
    return '';
  }
}

class Category {
  String? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

///
String chatId(String id1, String id2) {
  logs('id1 length => ${id1.length} id2 length=> ${id2.length}');
  if (id1.compareTo(id2) > 0) {
    return id1 + '-' + id2;
  } else {
    return id2 + '-' + id1;
  }
}
