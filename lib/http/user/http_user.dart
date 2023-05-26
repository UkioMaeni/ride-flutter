import 'package:dio/dio.dart';
import 'package:ezride/asyncStorage/tokenStorage/token_storage.dart';
import 'package:ezride/http/instanse.dart';
import 'package:ezride/http/token/httpToken.dart';

const baseUrl="http://31.184.254.86:9099/api/v1/client/info";
class HttpUser{
 
 Future<int> postUser(String nickname)async{

  String access= await TokenStorage().getToken("access");
  if(access=="no") return -1;
  print(access);
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

    print(response);
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
      int statusCode = error.response?.statusCode ?? -1;
      print(statusCode);
      print(error.response);
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