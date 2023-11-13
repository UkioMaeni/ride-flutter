
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/BLoC_navigation.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/menupages/message/message_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if(message.data["target"]=="Chat"){
        String chatId=message.data["entityId"];
           navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => MessagePage(chatId:int.parse(chatId) ),));
      }
}

Future<String> inicializeRirebase()async{
  try {
    await Firebase.initializeApp();
       FirebaseMessaging messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
   
    FirebaseMessaging.onMessageOpenedApp.listen((event) { 
      inspect(event);
      print(event.data.toString()+"mesage!!!!!");
      if(event.data["target"]=="Chat"){
        String chatId=event.data["entityId"];
           navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => MessagePage(chatId:int.parse(chatId) ),));
      }
     
     
    });
    FirebaseMessaging.onMessage.listen((event) {
      
     });
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      provisional: false,
      sound: true,
    );

     if(settings.authorizationStatus==AuthorizationStatus.authorized){
    print("AUTHORIZEFIREBASE");
  String? fcmToken = await messaging.getToken();
  print(fcmToken);

   



          InitializationSettings(
            iOS: DarwinInitializationSettings(),
          );
  //await FirebaseMessaging.instance.setAutoInitEnabled(true);
    //authorization
  return fcmToken??"";
  }
  } catch (e) {
      return "err"+e.toString();
  }
    
  return "";

}
