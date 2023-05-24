import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';


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

      var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date, true);
      date1 = dateTime.toLocal();

      if (date2.difference(date1).inSeconds < 60) {
        return "now";
      } else if (date2.difference(date1).inMinutes < 60) {
        return "${date2.difference(date1).inMinutes} min $ext";
      } else if (date2.difference(date1).inHours < 60) {
        return "${date2.difference(date1).inHours} h $ext";
      } else if (date2.difference(date1).inDays < 8) {
        return "${date2.difference(date1).inDays} d $ext";
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

String chatId(String id1, String id2) {
  logs('id1 length => ${id1.length} id2 length=> ${id2.length}');
  if (id1.compareTo(id2) > 0) {
    return id1 + '-' + id2;
  } else {
    return id2 + '-' + id1;
  }
}

OutlineInputBorder border = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey.shade200),
);

class CropImage {
  Future<File?> cropImage({
    required File image,
    required bool isBackGround,
    required BuildContext context,
  }) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: isBackGround
          ? [CropAspectRatioPreset.ratio16x9]
          : [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          hideBottomControls: true,
          initAspectRatio: isBackGround
              ? CropAspectRatioPreset.ratio16x9
              : CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          hidesNavigationBar: true,
          aspectRatioLockEnabled: true,
        )
      ],
    );
    logs('croppedFile:=>$croppedFile');
    if (croppedFile == null) {
      return null;
    }

    return File(croppedFile.path);
  }

  Future<File?> postCropImage({
    required File image,
    required bool isBackGround,
    required BuildContext context,
  }) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      // aspectRatioPresets: isBackGround
      //     ? [CropAspectRatioPreset.ratio3x2]
      //     : [CropAspectRatioPreset.square],

      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            initAspectRatio: CropAspectRatioPreset.original
            // initAspectRatio: isBackGround
            //     ? CropAspectRatioPreset.ratio16x9
            //     : CropAspectRatioPreset.square,
            ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          hidesNavigationBar: true,
          aspectRatioLockEnabled: true,
        )
      ],
    );
    logs('croppedFile:=>$croppedFile');
    if (croppedFile == null) {
      return null;
    }

    return File(croppedFile.path);
  }
}


/// ========================== CONST UTILS ========================== ///
class ConstUtils{
  static String selectedChattingUserId="";
}