import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/utils/const_utils.dart';

Future<void> shareContent(
    {required String postLink, required String postImg}) async {
  try {
    final String postDescription = "Hello, click on link";
    if (Platform.isAndroid) {
      var response = await http.get(Uri.parse(postImg));
      final documentDirectory = (await getExternalStorageDirectory())!.path;
      File imgFile = new File('$documentDirectory/flutter.png');
      imgFile.writeAsBytesSync(response.bodyBytes);

      Share.shareXFiles(
        [XFile('$documentDirectory/flutter.png')],
        subject: 'Post Share',
        text: '$postDescription\n$postLink',
      );
    } else {
      Share.share(
        'Hello, check your share files!',
        subject: 'URL File Share',
      );
    }
  } on Exception catch (e) {
    logs('SHARE POST ERROR =>$e');
    showSnackBar(message: "Post not share,Please try again");
  }
}
