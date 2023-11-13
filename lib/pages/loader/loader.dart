import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/app_version.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/helpers/firebaze_connect.dart';
import 'package:flutter_application_1/helpers/socket_connect.dart';
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



class AssetsElement{
  SvgPicture onBoard1=SvgPicture.asset("assets/svg/onboard_1.svg",height: 200,);
  SvgPicture onBoard2=SvgPicture.asset("assets/svg/onboard_2.svg",height: 200);
  SvgPicture onBoard3=SvgPicture.asset("assets/svg/onboard_3.svg",height: 250);
  SvgPicture onBoard4=SvgPicture.asset("assets/svg/onboard_4.svg",height: 300);
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

  




  initializeService(BuildContext context)async{
    nextStep();
    appInfo=AppInfo();
    await appInfo.getAppVersion();
   nextStep();
    ///firebase 
    String tokenFB=await inicializeRirebase();

         await Future.delayed(Duration(seconds: 2));
    nextStep();
     await auth(context,tokenFB,true);
      fullStep();
  
  
  }

  

@override
  void initState() {
    FirstWelcome().setWelcome();
    initializeService(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        bottomOpacity: 0,
        elevation: 0,
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset("assets/image/loader.png"),
          SizedBox(height: 80,),
          Text(
            "Welcome to iZZi Ride!",
            style: TextStyle(
              color: brandBlack,
              fontFamily: "SF",
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16,),
          Text(
            "Find a ride. Give a ride. Easy ride.",
            style: TextStyle(
              color: Color.fromRGBO(177, 178, 179, 1),
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
                color: Color.fromRGBO(58, 121, 215, 0.24),
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
                        color: Color.fromRGBO(58, 121, 215, 1)
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