import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/token/http_token.dart';
import 'package:flutter_application_1/tokenStorage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  Dio dio;
  AuthInterceptor(this.dio);

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(err.response?.data);
    if (err.response?.statusCode == 401) {
      // Получаем новый рефреш-токен
      final newToken = await HttpToken().refreshToken();
      String access="";
      if(newToken=="auth"){
        access= await TokenStorage().getToken("access");
      }

      // Обновляем рефреш-токен в заголовке запроса
      dio.options.headers['Authorization'] = 'Bearer $access';

      // Повторяем запрос с обновленным рефреш-токеном
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
      // Получаем новый рефреш-токен
        print(err.response?.data);

      handler.next(err);
    }
    

    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }
}