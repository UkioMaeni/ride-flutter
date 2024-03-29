import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/helpers/app_version.dart';
import 'package:flutter_application_1/http/token/http_token.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';

class ErrorTypeTimeout{

}

enum ErrorTypeTimeoutEnum{
  timeout,
}


class AuthInterceptor extends Interceptor {
  Dio dio;
  AuthInterceptor(this.dio);

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    
    if(err.error==DioExceptionType.sendTimeout){
      return ErrorTypeTimeout();
    }
    print(err.response?.data);
    if (err.response?.statusCode == 401) {
     
      final newToken = await HttpToken().refreshToken();
      String access="";
      if(newToken=="auth"){
        access= await TokenStorage().getToken("access");
      }

     
      dio.options.headers['Authorization'] = 'Bearer $access';

    
      final RequestOptions? options = err.response?.requestOptions;
      Response newResponse = await dio.request(
          options!.path, 
          data: options.data,
          queryParameters: options.queryParameters,
          options: options as Options,
          cancelToken: options.cancelToken);

      return newResponse;
    }
    if (err.response?.statusCode == 400) {
   
        print(err.response?.data);

      handler.next(err);
    }
    

    
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //print(options.queryParameters);
    print(options.queryParameters.toString());
    //print(options.baseUrl);
   // print(options.path);
   // print(options.queryParameters);
   options.headers.addEntries({
    MapEntry("version",appInfo.version)
   });
   //print("HV"+options.headers["version"]);
    handler.next(options);
  }
}