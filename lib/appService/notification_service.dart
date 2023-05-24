import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socialv/model/apiModel/responseModel/notification_chating_model.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/message/chatting.dart';

///---------------------------------------------------------------------------------------------------------------------------------
List<String> notiIds = [];

class NotificationService {
  ///notification
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// --------------------------- CLEAR ALL NOTIFICATIONS -------------------------- ///
  static Future<void> clearAllNotification() async {
    logs('CLEAR ALL NOTIFICATION CLICK');
    await flutterLocalNotificationsPlugin.cancelAll();
    logs('CLEAR ALL NOTIFICATION SUCCESS');
  }

  /// --------------------------- GET FCM TOKEN -------------------------- ///
  static Future<String> getDeviceToken() async {
    try {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      final deviceToken = await firebaseMessaging.getToken();
      return deviceToken ?? "";
    } on Exception catch (e) {
      logs('GET FCM TOKEN ERROR :=>$e');
      return "";
    }
  }

  /// --------------------------- SET CHANNEL NOTIFICATION FOR NOTIFICATION POP UP WHEN APP IN BACKGROUND -------------------------- ///
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    VariableUtils.appName,
    'Order Notifications',
    description: 'description',
    importance: Importance.high,
  );

  /// --------------------------- SET IOS NOTIFICATION PERMISSION -------------------------- ///
  static Future<void> notificationPermission() async {
    if (!Platform.isAndroid) {
      await firebaseMessaging.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          sound: true);
    }
  }

  /// --------------------------- SET PLATFORM CHANNEL SPECIFICATION -------------------------- ///
  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(
          android: AndroidNotificationDetails(
            VariableUtils.appName,
            'Notifications',
            channelDescription: 'description',
            color: Color(0xFFFFC0CB),
            playSound: true,
            importance: Importance.high,
            priority: Priority.max,
            icon: '@drawable/notification_icon',
          ),
          iOS: DarwinNotificationDetails());

  /// --------------------------- INITIALIZE NOTIFICATIONS -------------------------- ///
  static void inItNotification() async {
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    /// On notification click when app is open (local notification click)
    flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android:
                AndroidInitializationSettings('@drawable/notification_icon'),
            iOS: DarwinInitializationSettings()),
        onDidReceiveNotificationResponse: (notificationResponse) async {
      logs('FORE GROUND PAYLOAD :=>${notificationResponse.payload}');
      if (notificationResponse.payload == null) {
        return;
      }

      Map<String, dynamic> messageData =
          json.decode(notificationResponse.payload!);
      logs('FORE GROUND messageData=> $messageData');

      if (notiIds.contains(messageData['id'])) {
        return;
      } else {
        notiIds.add(messageData['id']);
      }
      routeScreenOnNotificationClick(
        data: messageData,
      );
    });
  }

  /// --------------------------- ON NOTIFICATION -------------------------- ///
  static void onNotification() {
    /// on notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      /// If `onMessage` is triggered with a notification, construct our own
      /// local notification to show to users using the created channel.
      if (notification != null && android != null) {
        logs('SHOW NOTI==>${jsonEncode(message.data)}');
        if(message.data.containsKey('notification_type')){
          if(message.data['notification_type']== NotificationType.Chatting.name){
            final notificationData =
            NotificationChattingModel.fromJson(jsonDecode(message.data['data']));
            if(notificationData.receiverId==ConstUtils.selectedChattingUserId){
              logs('SAME ID ------------------');
              return;
            }
          }
        }

        await flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title, notification.body, platformChannelSpecifics,
            payload: jsonEncode(message.data));
      }
    });

    /// when app is in background and user tap on it.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
      if (message != null) {
        Map<String, dynamic> messageData = message.data;
        logs(' BACK APP=> $messageData');
        if (notiIds.contains(messageData['id'])) {
          return;
        } else {
          notiIds.add(messageData['id']);
        }
        routeScreenOnNotificationClick(
          data: messageData,
        );
      }
    });

    /// when app is in terminated and user tap on it.
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        Map<String, dynamic> messageData = message.data;

        logs('terminated messageData=> $messageData');
        if (notiIds.contains(messageData['id'])) {
          return;
        } else {
          notiIds.add(messageData['id']);
        }
        routeScreenOnNotificationClick(
          data: messageData,
        );
      }
    });
  }

  /// --------------------------- BACKGROUND NOTIFICATIONS HANDLER-------------------------- ///
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    ///FIREBASE INITIALIZATION
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  /// --------------------------- SEND MANUALLY NOTIFICATIONS -------------------------- ///
  static Future<void> sendMessage(
      {required String receivedToken,
      required String msg,
      required String title,
      Map<String, dynamic>? data}) async {
    var serverKey =
        'AAAA5kQXpAE:APA91bH9h1uhkrbzrbfogx28ioyCk2RV6UMdOh3AQJCb03KNTsLnRvFjrSsF-yEWXDY6IkPYd2rYyxLS9iJHUPW4rWsCQBeP-5Cac6NB_p_D0qBpH_MDehB7haJ4i7Oi9y7YBrn5nsRV';

    if (receivedToken.isEmpty) {
      return;
    }

    try {
      String body = jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': msg,
            'title': title,
            "badge": "1",
            "sound": "default",
          },
          'priority': 'high',
          'data': data,
          'to': receivedToken,
        },
      );

      logs('NOTIFICATION REQ MODEL =>$body');

      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: body,
      );
      log("RESPONSE CODE ${response.statusCode}");
      log("RESPONSE BODY ${response.body}");
    } catch (e) {
      logs("error push notification");
    }
  }

  static Future<void> routeScreenOnNotificationClick({
    required Map<String, dynamic> data,
  }) async {
    log('DATA :=>$data');

    if (data['notification_type'] == NotificationType.Chatting.name) {
      final notificationData =
          NotificationChattingModel.fromJson(jsonDecode(data['data']));
      Get.to(() => ChattingScreen(
            senderId: notificationData.senderId!,
            senderImage: notificationData.senderImage!,
            senderName: notificationData.senderName!,
            receiverId: notificationData.receiverId!,
            receiverImage: notificationData.receiverImage!,
            receiverName: notificationData.receiverName!,
            receiverFcmToken: notificationData.receiverFcmToken!,
          ));
    }
  }
}
