import 'package:ezride/pages/mainapp/mainapp.dart';
import 'package:ezride/pages/mainapp/menupages/create/provider/provider.dart';
import 'package:ezride/pages/onboard/onboard.dart';
import 'package:ezride/pages/registration/registration.dart';
import 'package:ezride/pages/test_map.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(
          "flagusa"); // Замените на свою иконку приложения
  DarwinInitializationSettings ios = DarwinInitializationSettings();
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: ios);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  initFirebaseMessaging();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);

  final channel =
      IOWebSocketChannel.connect('ws://31.184.254.86:9099/api/v1/room/join');
  channel.stream.listen((message) {
    print(message);
  });
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => CreateProvider(),
    child: MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      initialRoute: "/menu",
      routes: {
        '/': (context) => const Onboard(),
        "/reg": (context) => const Registration(),
        "/menu": (context) => MainApp(
              channel: channel,
            ),
        "/map": (context) => MapSample()
      },
    ),
  ));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Обработка полученного уведомления в фоновом режиме

  debugPrint('Message data: ${message.data}');
  // Вывод уведомления
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id', // Замените на свой идентификатор канала
    'your_channel_name', // Замените на свое имя канала
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Уникальный идентификатор уведомления
    'Заголовок уведомления', // Замените на свой заголовок уведомления
    message.data['your_message_key'], // Замените на ключ вашего сообщения
    platformChannelSpecifics,
    payload: 'your_payload', // Замените на свои данные payload
  );
}

void showNotification(RemoteMessage message) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    '0',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );
  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? "",
    message.notification?.body ?? "",
    platformChannelSpecifics,
    payload: "pay",
  );
}

void initFirebaseMessaging() {
  var initializationSettingsAndroid = AndroidInitializationSettings("flagusa");
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    showNotification(message);
  });
}
