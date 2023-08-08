
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/localStorage/welcome/welcome.dart';
import 'package:flutter_application_1/localization/localization.dart';
import 'package:flutter_application_1/localization/localizationDelegats.dart';
import 'package:flutter_application_1/pages/loader/loader.dart';
import 'package:flutter_application_1/pages/menupages/mainapp.dart';
import 'package:flutter_application_1/onboard.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/registration/registration.dart';
import 'package:flutter_application_1/socket/socket.dart';
import 'package:flutter_application_1/sqllite/sqllite.dart';
import 'package:provider/provider.dart';







late SocketProvider appSocket;
late DataBaseApp appDB;



String appCode="";
void main() async {
  try {
      WidgetsBinding widgetsBinding=WidgetsFlutterBinding.ensureInitialized();
      Locale locale= LocalizationManager.getCurrentLocale();
  int isWelcome =await FirstWelcome().getWelocme();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SearchProvider>.value(
        value: SearchProvider(),
      ),
      ChangeNotifierProvider<CreateProvider>.value(
        value: CreateProvider(),
        
      ),
    ],
    child: MaterialApp(
          initialRoute: "/loader",
          routes: {
            '/': (context) => const Onboard(),
            "/loader":(context) => Loader(),
            "/reg": (context) => const Registration(),
            "/menu": (context) => const MainApp(),
          },
          locale: locale,
          supportedLocales: const[
             Locale("en","US"),
          ],
          localizationsDelegates:const [
            CustomLocalizationsDelegate()
          ],
        ),
        
    ),
  );
  } catch (e) {
    Dio().post(
      "https://ezride.requestcatcher.com/test",
      data: {
        "error":e
      }
    );
  }

    
  
}


