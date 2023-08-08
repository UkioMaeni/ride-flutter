import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import "package:flutter/services.dart";
import 'package:intl/intl.dart';


class LocalizationManager{
  Map<String, dynamic> _translations = {
    "app_name":"Easy Ride",
    "test":"test",
    "onboarding":{
        "title":"Your first car without\na driver's license",
        "one_info":"Goes to meet people who just got their\nlicense",
        "two_info":"Our company is a leader by the number of\ncars in the fleet",
        "three":"We will pay for you, all expenses related to\nthe car",
        "four":"Choose between regular car models\nor exclusive ones",
        "button":"next",
        "skip":"skip"
    },
    "registration":{
        "phone":"Your phone number",
        "otp":"OTP Verification",
        "address":"How do I address you?",
        "button_code":"Get code",
        "button_otp":"Continue",
        "button_sign":"Sign up"
    },
    "search":{
        "tab_name":"Search",
        "button":"Search"
    },
    "Create":{
        "tab_name":"Create"
    },
    "Message":{
        "tab_name":"Messages"
    },
    "Profile":{
        "tab_name":"Profile"
    },
    "card":{
        "hint_from":"From",
        "hint_to":"To"
    }
  };

  Future<void>loadTranslations(Locale locale)async{
  }
  String translate(String key) {
    return _translations[key] ?? 'Translation not found';
  }
   static Locale getCurrentLocale() {
    final currentLocale = Intl.getCurrentLocale();
    print('Current Locale: $currentLocale');
    List<String> localeInfo=currentLocale.split("_");
    Locale locale =Locale(localeInfo[0],localeInfo[1]);
    return locale;
  }
}