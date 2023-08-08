import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';
const baseUrl="http://31.184.254.86:9099/api/v1/refresh-token";
class HttpToken{
  Future<String> refreshToken() async{
    final token =await TokenStorage().getToken("refresh");
    print(token);
    if(token=="no"){
      return "noAuth";
    }

     Response response;

     Dio dio = Dio();
     dio.interceptors.add(InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) {
    // 
        int statusCode = error.response?.statusCode ?? -1;
        if(statusCode==400){

        }
    // Вызовите `handler.resolve(response)` для продолжения выполнения запроса в случае обработки ошибки, или `handler.next(error)` для передачи ошибки дальше
        handler.next(error);
  },
));
    try{
        
      response = await dio.post(
      baseUrl,
      data:  {
        "token":token
      }
      );
      await TokenStorage().setToken(response.data["data"]["access_token"], response.data["data"]["refresh_token"]);
      final to=await TokenStorage().getToken("access");
      print(to);
      return "auth";
    }catch(e){
      if(e is ErrorTypeTimeout){
        return ErrorTypeTimeoutEnum.timeout as String;
      }
      print(e);
        return "noAuth";
    }
      
  }
}