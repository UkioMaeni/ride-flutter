
import 'package:ezride/app_localization/app_localizations.dart';
import 'package:ezride/pages/mainapp/mainapp.dart';
import 'package:ezride/pages/mainapp/menupages/create/provider/provider.dart';
import 'package:ezride/pages/onboard/onboard.dart';
import 'package:ezride/pages/registration/registration.dart';
import 'package:ezride/pages/test_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{


// ...



 final channel = IOWebSocketChannel.connect('ws://31.184.254.86:9099/api/v1/room/join'); 
  channel.stream.listen((message) {
    print(message);
  });
  runApp( ChangeNotifierProvider(
      create: (BuildContext context)=>CreateProvider(),
      child: MaterialApp(
      localizationsDelegates: [
          AppLocalizations.delegate, // Делегат локализации для  приложения
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      initialRoute: "/menu",
      routes: {
        '/':(context)=> const Onboard(),
        "/reg":(context)=>const Registration(),
        "/menu":(context) =>  MainApp(channel: channel,),
        "/map":(context) => MapSample()
      },
    ),
  ) );
}

