import 'package:dio/dio.dart';
import 'package:ezride/asyncStorage/tokenStorage/token_storage.dart';
import 'package:flutter/material.dart';
const baseUrl="http://31.184.254.86:9099/api/v1/sign-up";
const baseUrlOtp="http://31.184.254.86:9099/api/v1/otp";
class HttpReg{
  Future<Map<String,dynamic>> otpVerify(int code, String phone) async{

    Response response;

    Dio dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, ErrorInterceptorHandler handler) {

        int statusCode = error.response?.statusCode ?? -1;

        if(statusCode==400){

        }
        print('Статус код ответа: $statusCode');
        print('Произошла ошибка: $error');
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
      print(response.data);
      return response.data["data"];
    }catch(e){
        print(e);
        return {};
    }
  }

  Future<Map<String,dynamic>> signIn(String phone) async{

     Response response;

     Dio dio = Dio(BaseOptions(
      baseUrl:baseUrl
     ));
     dio.interceptors.add(InterceptorsWrapper(
        onError: (DioError error, ErrorInterceptorHandler handler) {
    // 
        int statusCode = error.response?.statusCode ?? -1;
        if(statusCode==400){

        }
        print('Статус код ответа: $statusCode');
        print('Произошла ошибка: $error');
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
      print(response.data);
      return response.data["data"];
    }catch(e){
        print(e);
        return {};
    }
      
  }
}