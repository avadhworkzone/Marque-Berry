// import 'dart:ui' as ui;
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:tecell/utils/const_utils.dart';
//
// class GoogleMapMarkerPinService {
//   /// for my custom icons
//   static BitmapDescriptor? locationIcon;
//
//   static void setSourceAndDestinationIcons(markIcon) async {
//     logs('REST ICON:$locationIcon');
//     locationIcon = await getBitmapDescriptorFromAssetBytes(
//       markIcon.toString().toLowerCase() == "available"
//           ? "assets/svg/green_location.svg"
//           : "assets/svg/grey_location.svg",
//       70,
//     );
//     logs('AFTER REST ICON:$locationIcon');
//   }
//
//   static Future<Uint8List> getBytesFromAsset(String markIcon, int width) async {
//     ByteData data = await rootBundle.load(
//       markIcon.toString().toLowerCase() == "available"
//           ? "assets/svg/green_location.svg"
//           : "assets/svg/grey_location.svg",
//     );
//     logs('DATA :$data');
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
//
//   static Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
//       String path, int width) async {
//     final Uint8List imageData = await getBytesFromAsset(path, width);
//     logs('IMAGE DATA :$imageData');
//     return BitmapDescriptor.fromBytes(imageData);
//   }
// }
