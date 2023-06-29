import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/token/httpToken.dart';
import 'package:flutter_application_1/tokenStorage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  Dio dio;
  AuthInterceptor(this.dio);

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401) {
      // Получаем новый рефреш-токен
      final newToken = await HttpToken().refreshToken();
      String access="";
      if(newToken=="auth"){
        access= await TokenStorage().getToken("access");
      }

      // Обновляем рефреш-токен в заголовке запроса
      dio.options.headers['Authorization'] = 'Bearer $access';

      // Повторяем запрос с обновленным рефреш-токеном
      final RequestOptions options = response.requestOptions;
      Response newResponse = await dio.request(options.path, 
          data: options.data,
          queryParameters: options.queryParameters,
          options: options as Options,
          cancelToken: options.cancelToken);

      return response;
    }

    return super.onResponse(response, handler);
  }
}