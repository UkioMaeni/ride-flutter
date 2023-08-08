import 'package:shared_preferences/shared_preferences.dart';

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

setToken(String accessToken, String refreshToken) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("access", accessToken);
  prefs.setString("refresh", refreshToken);
  return 1;
}
Future<void> clearSharedPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  
}

}
