import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_cropping/image_cropping.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialv/utils/const_utils.dart';

class CropImageService {
  static Future<File> cropImage(
      {required BuildContext context, required String file}) async {
    print('cropImage------');
    final bytes = await File(file).readAsBytes();
    Uint8List imageBytes = bytes;

    final data = await ImageCropping.cropImage(
      context: context,
      imageBytes: bytes,
      onImageStartLoading: () {
        // showLoader();
      },
      onImageEndLoading: () {
        // hideLoader();
      },
      onImageDoneListener: (data) {
        // You can also use a listener instead of awaiting the function

        imageBytes = data;
      },
      selectedImageRatio: CropAspectRatio.free(),
      visibleOtherAspectRatios: true,
      squareBorderWidth: 2,
      // squareCircleColor: Colors.black,
      // defaultTextColor: Colors.orange,
      // selectedTextColor: Colors.black,
      // colorForWhiteSpace: Colors.grey,
      encodingQuality: 80,
      outputImageFormat: OutputImageFormat.png,
      // workerPath: 'crop_worker.js',
    );
    logs('PATH==>================');
    logs('DATA PATH==>================${data.runtimeType}');
    final image = await convertUint8ListToFile(data);
    logs('UIN PATH==>================${image.path}');
    return image;
  }

  static Future<File> convertUint8ListToFile(Uint8List imageInUnit8List) async {
    final tempDir = await getTemporaryDirectory();
    File file = await File(
            '${tempDir.path}/${DateTime.now().microsecondsSinceEpoch}.png')
        .create();
    file.writeAsBytesSync(imageInUnit8List);
    return file;
  }
}
