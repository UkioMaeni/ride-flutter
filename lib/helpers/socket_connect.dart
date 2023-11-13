 import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/http/chats/http_chats.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/http/token/http_token.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/onboard.dart';
import 'package:flutter_application_1/pages/menupages/provider/user_store.dart';
import 'package:flutter_application_1/socket/socket.dart';
import 'package:flutter_application_1/sqllite/sqllite.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<void>  auth(BuildContext context,String? fcmToken,bool auto)async{
  String next=await HttpToken().refreshToken();
  if(next==ErrorTypeTimeoutEnum.timeout){
      showDialog(context: context, builder: (context) {
        return Center(
          child: Text("timeout"),
        );
      },);
      await Future.delayed(Duration(seconds: 2));
  }
  print(next);
  String token=await TokenStorage().getToken("refresh");
  if(next=="auth" && token !="no"){
    final wsUrl = Uri.parse("ws://31.184.254.86:9099/api/v1/chat/join");

      userStore.userInfo.auth=true;
      try {
        late Timer authCheckTimer;
        WebSocketChannel channel = WebSocketChannel.connect(wsUrl);
        appSocket=SocketProvider(channel: channel);
        appDB=DataBaseApp();
       //appDB.create();
        //appSocket.insertMsgFromDB();
        authCheckTimer = Timer.periodic(Duration(milliseconds: 100), (timer)async {
          bool isAuth= appSocket.isAuth;
          if(isAuth){
            authCheckTimer.cancel();
            if(fcmToken!=null){
                await HttpChats().setFcmToken(fcmToken);
                
            }
            
            
          auto?Navigator.pushNamedAndRemoveUntil(context, "/menu", (route) => false):null;
         }
        });
       
        
      } catch (e) {
        showDialog(
          context: context, 
          builder: (context) => Dialog(child: Text(e.toString()),)
          );
          await Future.delayed(Duration(seconds: 2));
        
      }
   
      
     // StreamController<dynamic> streamController = StreamController<dynamic>();
   // Navigator.pushReplacementNamed(context,"/menu" );
  }else{
          await Future.delayed(Duration(seconds: 2));
    Navigator.pushAndRemoveUntil(context, 
    MaterialPageRoute(builder: (context) => Onboard(),), (route) => false);
  }
 } 