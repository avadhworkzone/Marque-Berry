// import 'dart:ui';
// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:tecell/utils/const_utils.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
//
// import 'controllers/map_controller.dart';
//
// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//   late ClusterManager clusterManager;
//   MapController mapController = Get.put(MapController());
//
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//
//   Set<Marker> markers = {};
//
//   //////////
//   final CameraPosition _parisCameraPosition = const CameraPosition(
//     target: LatLng(21.1702, 72.8311),
//     zoom: 14.0,
//   );
//
//   @override
//   void initState() {
//     clusterManager = _initClusterManager();
//     super.initState();
//   }
//
//   bool loadData = false;
//
//   ClusterManager _initClusterManager() {
//     logs('${mapController.erAllConnectorList.length} ======================');
//     return ClusterManager<Place>(
//       (List.generate(mapController.erAllConnectorList.length, (i) {
//         return Place(
//           latLng: LatLng(
//             mapController.erAllConnectorList[i].latitude.toDouble(),
//             mapController.erAllConnectorList[i].longLatitude.toDouble(),
//           ),
//         );
//       })).toList(),
//       // [
//       //   Place(latLng: const LatLng(23.0488, 72.6083)),
//       //   Place(latLng: const LatLng(23.0397, 72.5922)),
//       //   Place(latLng: const LatLng(23.0225, 72.5714)),
//       //   Place(latLng: const LatLng(21.2266, 72.8312)),
//       //   Place(latLng: const LatLng(21.1418, 72.7709)),
//       //   Place(latLng: const LatLng(21.2148, 72.8888)),
//       //   Place(latLng: const LatLng(21.2348, 72.8162)),
//       //   Place(latLng: const LatLng(21.1959, 72.7933)),
//       //   Place(latLng: const LatLng(21.1521, 72.8717)),
//       // ],
//       (Set<Marker> markers) {
//         setState(() {
//           this.markers = markers;
//           logs("${markers.length}    <========= LENGTH =========");
//         });
//       },
//       markerBuilder: _markerBuilder,
//     );
//   }
//
//   Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
//       (cluster) async {
//         return Marker(
//           markerId: MarkerId(cluster.getId()),
//           position: cluster.location,
//           icon: await _getMarkerBitmap(80, text: cluster.count.toString()),
//         );
//       };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           loadData == true
//               ? const CircularProgressIndicator(
//                   backgroundColor: Colors.red,
//                 )
//               : Expanded(
//                   child: GoogleMap(
//                     markers: markers,
//                     mapType: MapType.normal,
//                     initialCameraPosition: _parisCameraPosition,
//                     onMapCreated: (GoogleMapController controller) {
//                       clusterManager = _initClusterManager();
//                       _controller.complete(controller);
//                       clusterManager.setMapId(controller.mapId);
//                     },
//                     onCameraIdle: clusterManager.updateMap,
//                     onCameraMove: clusterManager.onCameraMove,
//                   ),
//                 ),
//           ElevatedButton(
//             onPressed: () async {
//               setState(() {
//                 loadData = true;
//               });
//               await Future.delayed(const Duration(seconds: 5), () {
//                 // manager = _initClusterManager();
//                 // manager.updateMap();
//               });
//               setState(() {
//                 loadData = false;
//               });
//             },
//             child: const Text("data"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
//     if (kIsWeb) size = (size / 2).floor();
//
//     final PictureRecorder pictureRecorder = PictureRecorder();
//     final Canvas canvas = Canvas(pictureRecorder);
//     final Paint paint1 = Paint()..color = Colors.black;
//     final Paint paint2 = Paint()..color = Colors.white;
//
//     canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
//     canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
//     canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);
//
//     if (text != null) {
//       TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
//       painter.text = TextSpan(
//         text: text,
//         style: TextStyle(
//           fontSize: size / 3,
//           color: Colors.white,
//           fontWeight: FontWeight.normal,
//         ),
//       );
//       painter.layout();
//       painter.paint(
//         canvas,
//         Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
//       );
//     }
//
//     final img = await pictureRecorder.endRecording().toImage(size, size);
//     final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;
//
//     return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
//   }
// }
//
// // class Place {
// //   final LatLng latLng;
// //
// //   Place({required this.latLng});
// //
// //   @override
// //   LatLng get location => latLng;
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:tecell/utils/const_utils.dart';
// import 'package:tecell/utils/variable_utils.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:tecell/commanWidget/custom_btn.dart';
//
// class TestPayment extends StatefulWidget {
//   const TestPayment({Key? key}) : super(key: key);
//
//   @override
//   State<TestPayment> createState() => _TestPaymentState();
// }
//
// class _TestPaymentState extends State<TestPayment> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: CustomBtn(
//           onTap: () async {
//             await makePayment();
//           },
//           text: "PAYMENT",
//         ),
//       ),
//     );
//   }
//
//   Future<void> onGooglePayResult() async {
//     paymentIntent = await createPaymentIntent('100', 'INR');
//     // final response = await fetchPaymentIntentClientSecret();
//     final clientSecret = paymentIntent!['clientSecret'];
//     final token =
//         paymentIntent!['paymentMethodData']['tokenizationData']['token'];
//     final tokenJson = Map.castFrom(json.decode(token));
//
//     logs(token.toString());
//     //
//     // final params = PaymentMethodParams.cardFromToken(
//     //   token: tokenJson['id'],
//     // );
//     // // Confirm Google pay payment method
//     // await Stripe.instance.confirmPayment(
//     //   clientSecret,
//     //   params,
//     // );
//   }
//
//   Map<String, dynamic>? paymentIntent;
//
//   Future<void> makePayment() async {
//     try {
//       paymentIntent = await createPaymentIntent('100', 'INR');
//
//       logs("PAYMENT INTENT ----------------> $paymentIntent");
//       if (paymentIntent == null) {
//         return;
//       }
//       logs('AFTER IF....');
//       var gpay = const PaymentSheetGooglePay(
//         merchantCountryCode: "US",
//         currencyCode: "US",
//         testEnv: true,
//       );
//       logs("STEP 1");
//       //STEP 2: Initialize Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntent!['client_secret'],
//           style: ThemeMode.light,
//           merchantDisplayName: 'Abhishek',
//           googlePay: gpay,
//           customFlow: true,
//         ),
//       )
//           .then((value) {
//         logs("THEN....");
//       }).catchError((onError) {
//         logs("CATCH ERROR.... $onError");
//       });
//       logs("STEP 2");
//       logs("-------> ${paymentIntent!['client_secret']}");
//       //STEP 3: Display Payment sheet
//       displayPaymentSheet(paymentIntent!['client_secret']);
//     } catch (err) {
//       logs('$err ----------');
//     }
//   }
//
//   displayPaymentSheet(clientSecret) async {
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) async {
//         logs("Payment Successfully");
//       }).catchError((onError) => logs('ON ERROR.... $onError'));
//       logs("Stpe3...");
//     } catch (e) {
//       print('DISPLAY:===> $e');
//     }
//   }
//
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'currency': currency,
//       };
//
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer ${VariableUtils.testSecreatKey}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       print("Err :====> $err");
//       // throw Exception(err.toString());
//       return null;
//     }
//   }
// }
//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
// import 'package:tecell/utils/const_utils.dart';
// import 'package:tecell/utils/variable_utils.dart';
//
// class TestPayment extends StatefulWidget {
//   const TestPayment({Key? key}) : super(key: key);
//
//   @override
//   _TestPaymentState createState() => _TestPaymentState();
// }
//
// class _TestPaymentState extends State<TestPayment> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             OutlinedButton(
//               onPressed: () async {
//                 try {
//                   await postCreatePaymentIntent();
//                 } catch (e) {
//                   logs('Error...  $e');
//                 }
//               },
//               child: const Text('data'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Map<String, dynamic>? paymentIntent;
//   createPaymentIntent() async {
//     try {
//       Map<String, dynamic> body = {
//         // 'payment_method_types': ["upi"],
//         // 'mode': 'payment',
//         'amount': "10000",
//         'currency': 'usd',
//         // "payment_method_types[]": "card",
//         // "confirm": 'true',
//       };
//
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer ${VariableUtils.testSecreatKey}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       print("Err :====> $err");
//       throw Exception(err.toString());
//       return null;
//     }
//   }
//
//   Future<void> postCreatePaymentIntent() async {
//     final uri = Uri.parse("https://api.stripe.com/v1/payment_intents");
//
//     final response = await http.post(
//       uri,
//       headers: {
//         'Authorization': 'Bearer ${VariableUtils.testSecreatKey}',
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: {
//         // "upi": "temp@okhdfc.com",
//         // "amount": "100",
//         // "currency": "inr",
//         //
//         // "upi": "temp@okhdfc",
//         "payment_method_types[]": "upi",
//         "currency": "inr",
//         "amount": "100",
//         "vpa": "payment.success@stripeupi",
//       },
//     );
//     logs('${response.statusCode}  ${response.body}');
//     if (response.statusCode == 200) {
//       logs('200... ');
//       return jsonDecode(response.body);
//     } else {}
//   }
// }
