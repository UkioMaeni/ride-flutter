import 'package:dio/dio.dart';
const baseUrl="http://31.184.254.86:9099/api/v1/sign-up";
const baseUrlOtp="http://31.184.254.86:9099/api/v1/otp";
class HttpReg{
  Future<Map<String,dynamic>> otpVerify(int code, String phone) async{

    Response response;

    Dio dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {

        int statusCode = error.response?.statusCode ?? -1;

        if(statusCode==400){

        }
    // `handler.resolve(response)` для продолжения выполнения запроса в случае обработки ошибки,`handler.next(error)` для передачи ошибки дальше
        handler.next(error);
  },
));
    try{

      response = await dio.post(
      baseUrlOtp,
      data:  {
        "code":code,
        "phone": phone,
        "step": "sign-up"
      }
      );
      return response.data["data"];
    }catch(e){
        return {};
    }
  }

  Future<Map<String,dynamic>> signIn(String phone) async{

     Response response;

     Dio dio = Dio(BaseOptions(
      baseUrl:baseUrl
     ));
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
        "phone":phone
      }
      );
      return response.data["data"];
    }catch(e){
        return {};
    }
      
  }
}