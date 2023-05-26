
import 'package:ezride/pages/mainapp/mainapp.dart';
import 'package:ezride/pages/onboard/onboard.dart';
import 'package:ezride/pages/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';


void main() {
 final channel = IOWebSocketChannel.connect('ws://31.184.254.86:9099/api/v1/room/join'); 
  channel.stream.listen((message) {
    print(message);
  });
  runApp( MaterialApp(
    initialRoute: "/reg",
    routes: {
      '/':(context)=> const Onboard(),
      "/reg":(context)=>const Registration(),
      "/menu":(context) =>  MainApp(channel: channel,),
    },
  ) );
}

