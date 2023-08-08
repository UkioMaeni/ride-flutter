import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

      static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: DarwinInitializationSettings(),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {
        print(details);
      },
    );
  }
static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
       
        iOS: DarwinNotificationDetails(
          presentSound: true
        )
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}