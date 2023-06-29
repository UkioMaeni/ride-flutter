import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/tokenStorage/token_storage.dart';
const baseUrl="http://31.184.254.86:9099/api/v1/refresh-token";
class HttpToken{
  Future<String> refreshToken() async{
    final token =await TokenStorage().getToken("refresh");
    if(token=="no"){
      return "noAuth";
    }
    print("refresh_token: $token");

     Response response;

     Dio dio = Dio();
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
        "token":token
      }
      );
      print(response.data);
      await TokenStorage().setToken(response.data["data"]["access_token"], response.data["data"]["refresh_token"]);
      return "auth";
    }catch(e){
        print(e);
        return "noAuth";
    }
      
  }
}