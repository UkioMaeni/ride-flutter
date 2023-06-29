
import 'package:flutter/material.dart';
import 'package:flutter_application_1/mainapp.dart';
import 'package:flutter_application_1/onboard.dart';
import 'package:flutter_application_1/pages/mainapp/create/provider/provider.dart';
import 'package:flutter_application_1/registration/registration.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => CreateProvider(),
    child: MaterialApp(
      initialRoute: "/",
      routes: {
        '/': (context) => const Onboard(),
        "/reg": (context) => const Registration(),
        "/menu": (context) => MainApp(),
      },
    ),
  ));
}



