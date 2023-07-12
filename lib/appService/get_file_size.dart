import 'dart:io';
import 'dart:math';

Future<double> getFileSize(
    {required String filepath, required int convertType}) async {
  var file = File(filepath);

  final bytes = file.readAsBytesSync().lengthInBytes;

  print('AFTER FILE LENGTH :=>$bytes');

  final kb = bytes / 1024;
  final mb = kb / 1024;
  return mb;

  // int bytes = await file.length();
  // if (bytes <= 0) return "0 B";
  // const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  // var i = (log(bytes) / log(1024)).floor();
  // return ((bytes / pow(1024, i)).toStringAsFixed(convertType));
}
