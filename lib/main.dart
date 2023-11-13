
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/BLoC_navigation.dart';
import 'package:flutter_application_1/localStorage/welcome/welcome.dart';
import 'package:flutter_application_1/localization/localization.dart';
import 'package:flutter_application_1/localization/localizationDelegats.dart';
import 'package:flutter_application_1/pages/loader/loader.dart';
import 'package:flutter_application_1/pages/menupages/mainapp.dart';
import 'package:flutter_application_1/onboard.dart';
import 'package:flutter_application_1/pages/menupages/message/message_page.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/registration/registration.dart';
import 'package:flutter_application_1/socket/socket.dart';
import 'package:flutter_application_1/sqllite/sqllite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';







late SocketProvider appSocket;
late DataBaseApp appDB;



String appCode="";
late BuildContext contextApp;
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
          // initialRoute: "/loader",
          // routes: {
          //   '/': (context) => const Onboard(),
          //   "/loader":(context) => Loader(),
          //   "/reg": (context) => const Registration(),
          //   "/menu": (context) => const MainApp(),
          //   "/message":(context) => MessagePage(chatId: 0, userId: 0)
          // },
          navigatorKey: navigatorKey,
          initialRoute: "/loader",
          routes: {
            "/loader":(context) => Loader(),
            "/menu":(context) => const MainApp(),
            "/reg":(context) => const Registration()
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


