import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';

const baseUrl="http://31.184.254.86:9099/api/v1/client/info";
const baseAppUrl="http://31.184.254.86:9099/api/v1/";
class UserData{
  static Error err=Error();
  bool auth;
  int clienId;
  int dateOfBirth;
  String photo;
  String name;
  String surname;
  String nickname;
  String gender;
  UserData({
    required this.auth,
    required this.clienId,
    required this.dateOfBirth,
    required this.gender,
    required this.name,
    required this.nickname,
    required this.photo,
    required this.surname
    });
}


class HttpUser{
 
 Future<int> createUser(String nickname)async{

  String access= await TokenStorage().getToken("access");
  if(access=="no") return -1;
  Dio dio = Dio(
    BaseOptions(
      headers: {
        "Authorization":"Bearer $access"
      }
      )
    );
    final authInterceptor = AuthInterceptor(dio);

  dio.interceptors.add(authInterceptor);

  Response response; 
  try{
    response = await dio.post(
    "http://31.184.254.86:9099/api/v1/client/info",
    data: {
      "nickname":nickname
    } 
    );
    return 0;
  }catch(e){
      return -1;
  }
 
 }

 Future<int> editUser(String nickname)async{

  String access= await TokenStorage().getToken("access");
  if(access=="no") return -1;
  Dio dio = Dio(
    BaseOptions(
      headers: {
        "Authorization":"Bearer $access"
      }
      )
    );
    final authInterceptor = AuthInterceptor(dio);

  dio.interceptors.add(authInterceptor);

  Response response; 
  try{
    response = await dio.put(
    "http://31.184.254.86:9099/api/v1/client/info",
    data: {
      "nickname":nickname
    } 
    );
    print(response.data);
    return 0;
  }catch(e){
      return -1;
  }
 
 }

 Future<UserData?> getUser()async{
   String access= await TokenStorage().getToken("access");
   Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Authorization":"Bearer $access"
      }
      )
    );

  dio.interceptors.add(InterceptorsWrapper(
    onError: (error, handler){
      handler.next(error);
    },
  ));

  Response response; 

  try{
    response = await dio.get(
      baseUrl,
      options: Options(
        headers: {
          "Authorization":"Bearer $access"
        }
      )
    );
    print("userDataRepsonse");
    print(response.data);
    final res=response.data["data"];
    return UserData(
      auth: true,
      clienId: res["client_id"]??-1,
      dateOfBirth: res["date_of_birth"]??0, 
      gender: res["gender"]??0, 
      name: res["name"]??"", 
      nickname: res["nickname"]??"", 
      photo: res["photo"]??"", 
      surname: res["surname"]??"");
  }catch(e){
    print(e);
    return null;
  }
 }

 Future<bool?> getPermission(String permission)async{
       String access= await TokenStorage().getToken("access");
        Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Authorization":"Bearer $access"
      }
      )
    );

  dio.interceptors.add(InterceptorsWrapper(
    onError: (error, handler){
      handler.next(error);
    },
  ));
       try {
       Response  response = await dio.get(
      "${baseAppUrl}client/permission/${permission}",
      options: Options(
        headers: {
          "Authorization":"Bearer $access"
        }
      )
    
    );
    print("perm");
      print(response.data["data"]["permission"]);
      bool permissionVal=response.data["data"]["permission"]??false;
      return permissionVal;
       } catch (e) {
         print(e);
         false;
       }
 }

 Future<int> deleteUser()async{

  String access= await TokenStorage().getToken("access");
  if(access=="no") return -1;
  Dio dio = Dio(
    BaseOptions(
      headers: {
        "Authorization":"Bearer $access"
      }
      )
    );
    final authInterceptor = AuthInterceptor(dio);

  dio.interceptors.add(authInterceptor);

  Response response; 
  try{
    response = await dio.delete(
    "http://31.184.254.86:9099/api/v1/client",
    );
    print(response.data);
    return 0;
  }catch(e){
      return -1;
  }
 
 }
}