import 'package:dio/dio.dart';
const baseUrl="http://31.184.254.86:9099/api/v1/sign";
const baseUrlOtp="http://31.184.254.86:9099/api/v1/otp";
class HttpReg{
  Future<Map<String,dynamic>?> otpVerify(int code, String phone) async{

    Response response;

    Dio dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {

        int statusCode = error.response?.statusCode ?? -1;

        if(statusCode==400){

        }
   
        handler.next(error);
  },
));
    try{

      response = await dio.post(
      baseUrlOtp,
      data:  {
        "code":code,
        "phone": phone,
        "step": "sign"
      }
      );
      print("otpVerif");
      print(response.data["data"]);
      return response.data["data"];
    }catch(e){
      print(e);
        return null;
    }
  }

  Future<Map<String,dynamic>> signIn(String phone) async{

     Response response;

     Dio dio = Dio(BaseOptions(
      baseUrl:baseUrl
     ));
     dio.interceptors.add(InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) {
        print(error);
        int statusCode = error.response?.statusCode ?? -1;
        if(statusCode==400){

        }
  
        handler.next(error);
  },
));
    try{
      print(phone);
      response = await dio.post(
      baseUrl,
      data:  {
        "phone":phone
      }
      );
      print(response.data);
      return response.data["data"];
    }catch(e){
        return {};
    }
      
  }
}