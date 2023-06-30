
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/menupages/mainapp.dart';
import 'package:flutter_application_1/onboard.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/registration/registration.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();



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
          initialRoute: "/",
          routes: {
            '/': (context) => const Onboard(),
            "/reg": (context) => const Registration(),
            "/menu": (context) => const MainApp(),
          },
        ),
    ),
  );
}



