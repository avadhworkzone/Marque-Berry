import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/view/template/download_template_listview.dart';

class ImageDownload {
  DownloadTemplateController downloadTemplateController =
      Get.find<DownloadTemplateController>();

  Future<void> getStoragePermission({required String path}) async {
    var storageStatus = await Permission.storage.status;
    if (storageStatus != PermissionStatus.granted) {
      await Permission.storage.request();
    }

    var storageStatusAgain = await Permission.storage.status;
    if (storageStatusAgain == PermissionStatus.granted) {
      downloadImage(path);
    }
  }

  var dio = Dio();

  Future downloadImage(String url) async {
    try {
      final response = await dio.get(
        url,
        onReceiveProgress: downloadTemplateController.progressDownload,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      String savePath = (await getDownloadPath()) ?? '';
      if (savePath == "") {
        showSnackBar(message: "Download failed");
        return;
      }

      File file = File("$savePath/adoro_${url.split("/").last}");

      logs("FILE PATH -----> $savePath  ");
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      showSnackBar(
        message: "Image downloaded successfully",
        snackbarSuccess: true,
      );
    } catch (e) {
      print("Error image download :-----> $e");
    }
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        final existsPathStatus = await directory.exists();
        if (!existsPathStatus) directory = await getExternalStorageDirectory();
      }
      return directory?.path;
    } catch (err) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<String> tempDownloadImage(String url) async {
    try {
      final response = await dio.get(
        url,
        onReceiveProgress: downloadTemplateController.progressDownload,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      final Directory tempDir = await getTemporaryDirectory();
      File file = File("${tempDir.path}/adoro_${url.split("/").last}");
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      // await file.writeAsBytes(response.data);
      return file.path;
    } catch (e) {
      print("Error image download :-----> $e");
      return '';
    }
  }
}
