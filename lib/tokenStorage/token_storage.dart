import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class TokenStorage{
   getToken(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(type=="access"){
      String? refresh=  prefs.getString("access");
      refresh ??= "no";
      return  refresh;
    }
    if(type=="refresh"){
      String? refresh=  prefs.getString("refresh");
      refresh ??= "no";
      return  refresh;
    }
  
 
}

setToken(String access_token, String refresh_token) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("access", access_token);
  prefs.setString("refresh", refresh_token);
  return 1;
}

}
