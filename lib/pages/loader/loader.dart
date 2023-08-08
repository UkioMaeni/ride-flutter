import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/http/chats/http_chats.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/http/token/http_token.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';
import 'package:flutter_application_1/localStorage/welcome/welcome.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/onboard.dart';
import 'package:flutter_application_1/registration/registration.dart';
import 'package:flutter_application_1/socket/socket.dart';
import 'package:flutter_application_1/sqllite/sqllite.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

}

class AssetsElement{
  SvgPicture onBoard1=SvgPicture.asset("assets/svg/onboard_1.svg");
  SvgPicture onBoard2=SvgPicture.asset("assets/svg/onboard_2.svg");
  SvgPicture onBoard3=SvgPicture.asset("assets/svg/onboard_3.svg");
  SvgPicture onBoard4=SvgPicture.asset("assets/svg/onboard_4.svg");
}

AssetsElement appAssets=AssetsElement();


class Loader extends StatefulWidget{
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {

double _progressValue=0.0;

  nextStep(){
    setState(() {
      _progressValue+=0.1;
    });
  }
  fullStep(){
    setState(() {
      _progressValue=1.0;
    });
  }

   void  isAuth(BuildContext context,String? fcmToken)async{
  String next=await HttpToken().refreshToken();
  if(next==ErrorTypeTimeoutEnum.timeout){
      showDialog(context: context, builder: (context) {
        return Center(
          child: Text("timeout"),
        );
      },);
  }
  nextStep();
  String token=await TokenStorage().getToken("refresh");
  nextStep();
  if(next=="auth" && token !="no"){
    final wsUrl = Uri.parse("ws://31.184.254.86:9099/api/v1/chat/join");

      
      try {
        late Timer authCheckTimer;
        WebSocketChannel channel = WebSocketChannel.connect(wsUrl);
        appSocket=SocketProvider(channel: channel);
        appDB=DataBaseApp();
       //appDB.create();
        appSocket.insertMsgFromDB();
        authCheckTimer = Timer.periodic(Duration(milliseconds: 100), (timer)async {
          bool isAuth= appSocket.isAuth;
          if(isAuth){
            authCheckTimer.cancel();
            if(fcmToken!=null){
                await HttpChats().setFcmToken(fcmToken);
                nextStep();
            }
            
            fullStep();
          Navigator.pushNamedAndRemoveUntil(context, "/menu", (route) => false);
         }
        });
       
        
      } catch (e) {
        print(e);
        
      }
     fullStep();
      
     // StreamController<dynamic> streamController = StreamController<dynamic>();
   // Navigator.pushReplacementNamed(context,"/menu" );
  }else{
    Navigator.pushAndRemoveUntil(context, 
    MaterialPageRoute(builder: (context) => Onboard(),), (route) => false);
  }
 } 




  initializeService(BuildContext context)async{
   await Firebase.initializeApp();
   nextStep();
    ///firebase 
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  provisional: false,
  sound: true,
);
  nextStep();
   if(settings.authorizationStatus==AuthorizationStatus.authorized){
    print("AUTHORIZEFIREBASE");
  String? fcmToken = await messaging.getToken();
  print(fcmToken);
  nextStep();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
      showSimpleNotification(
        Text("Test"),
        leading: Text("3"),
        subtitle: Text("sub"),
        background: Colors.cyan,
        duration: Duration(seconds: 2)
      );
    });
          InitializationSettings(
            iOS: DarwinInitializationSettings(),
          );
  //await FirebaseMessaging.instance.setAutoInitEnabled(true);
  nextStep();
    //authorization
  isAuth(context,fcmToken);
  }
  }

  

@override
  void initState() {
    FirstWelcome().setWelcome();//TODO: больше нет показа онбординга
    initializeService(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(64, 123, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(64, 123, 255, 1),
        toolbarHeight: 0,
        bottomOpacity: 0,
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Добро пожаловать в EasyRide! ",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "SF",
              fontSize: 32,
              fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Объединяем\nпопутчиков во всем мире",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "SF",
              fontSize: 18,
              fontWeight: FontWeight.w400
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 68.75,
              left: 38,
              right: 38,
              top: 108.75
            ),
            child: Container(
              width: double.infinity,
              height: 10.5,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.56),
                borderRadius: BorderRadius.circular(7)
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _progressValue,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}