import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/city/city_model.dart';
import 'package:flutter_application_1/http/instanse.dart';

const baseUrl="http://31.184.254.86:9099/api/v1/city";


class HttpCity{

  Future<List<CityModel>> getCity(String city) async{
    Dio dio=Dio();

    Response response;

    final authInterceptor=AuthInterceptor(dio);
    dio.interceptors.add(authInterceptor);

   response=await dio.get(
    baseUrl,
    queryParameters: {
        "name":city
    }
    );
    
    List res=response.data["data"];
    List<CityModel> cityList=[];
    for (var element in res) {
      cityList.add(CityModel(element["city_id"], element["state_id"], element["city"], element["state"], element["county"], element["longitude"], element["latitude"]));
    }
    print(cityList.toString());
    return cityList;
  }
}