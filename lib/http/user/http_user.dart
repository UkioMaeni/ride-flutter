import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';

const baseUrl="http://31.184.254.86:9099/api/v1/client/info";
class HttpUser{
 
 Future<int> postUser(String nickname)async{

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

 Future<Map<String,dynamic>> getUser()async{
   String access= await TokenStorage().getToken("access");
  if(access=="no") return {};
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
    print(response.data);
    return {};
  }catch(e){
    return {};
  }
 }
}