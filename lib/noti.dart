import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:noti/notification_screen.dart';
import 'package:http/http.dart' as http;

class CustomNoti {
  final firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.defaultImportance,
  );

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Handling a background message ${message.notification?.title}');
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.body}');

    // if (message.notification == null) {
    //   print('Message also contained a notification: ${message.notification}');
    //   return;
    // }
    // Get.to(() => NotificationScreen(message: message));
  }

  void handleMessage(RemoteMessage message) {
    if (message.notification == null) {
      print('Message also contained a notification: ${message.notification}');
      return;
    }
    Get.to(() => NotificationScreen(message: message));
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((message) => handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) => () {
          final notification = message.notification;
          if (notification != null) {
            final android = message.notification?.android;
            if (android != null) {
              _flutterLocalNotificationsPlugin.show(
                  notification.hashCode,
                  notification.title,
                  notification.body,
                  NotificationDetails(
                    android: AndroidNotificationDetails(
                      _androidChannel.id,
                      _androidChannel.name,
                      channelDescription: _androidChannel.description,
                      icon: '@mipmap/ic_launcher',
                      importance: _androidChannel.importance,
                      priority: Priority.high,
                      playSound: true,
                      showWhen: true,
                      enableVibration: true,
                      channelShowBadge: true,
                    ),
                  ),
                  payload: jsonEncode(message.toMap()));
            }
          }
        });
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(body ?? ""),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              // Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

  Future initLocalNotification() async {
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const ANDROID = AndroidInitializationSettings('@mipmap/ic_launcher');
    final INIT_SETTING = InitializationSettings(
        iOS: initializationSettingsDarwin, android: ANDROID);
    await _flutterLocalNotificationsPlugin.initialize(INIT_SETTING);

    final platform =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!;
    await platform.createNotificationChannel(_androidChannel);

    FirebaseMessaging.onMessage.listen((message) => () {
          print("listen forgetground");
          final notification = message.notification;
          if (notification != null) {
            final android = message.notification?.android;
            if (android != null) {
              _flutterLocalNotificationsPlugin.show(
                  notification.hashCode,
                  notification.title,
                  notification.body,
                  NotificationDetails(
                    android: AndroidNotificationDetails(
                      _androidChannel.id,
                      _androidChannel.name,
                      channelDescription: _androidChannel.description,
                      icon: '@mipmap/ic_launcher',
                      importance: _androidChannel.importance,
                      priority: Priority.high,
                      playSound: true,
                      showWhen: true,
                      enableVibration: true,
                      channelShowBadge: true,
                    ),
                  ),
                  payload: jsonEncode(message.toMap()));
            }
          }
        });
  }

  static sendNotification() async {
    String token = 'Your toekn';
    final response =
        await http.post(Uri.parse('https://fcm.google.com/fcm/send'), headers: {
      "Authorization": "Bearer $token",
    }, body: {
      "to": "",
      "notification": {
        "title": "Hello",
        "body": "World",
      },
    });
    print('Message sent successfully: $response');
  }

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final token = await firebaseMessaging.getToken();
    print('Token: $token');

    initPushNotification();
    initLocalNotification();
  }
}
