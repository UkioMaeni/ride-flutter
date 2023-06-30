import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';

class CarsHttp{


  Future<List<CarModel>> getName(String text)async{
    Dio dio=Dio();
    Response response;

    AuthInterceptor interceptor=AuthInterceptor(dio);

    dio.interceptors.add(interceptor);
    
    response=await dio.get(
      "http://31.184.254.86:9099/api/v1/car/manufacturer",
      queryParameters: {
        "name":text
      }
    );
      List<CarModel> carModels = [];
      List<dynamic> data = response.data["data"];
      carModels = data.map((item) => CarModel(item["id"], item["name"])).toList();
  
    return carModels;
  }

  Future<List<CarModel>> getModel(String text,int id)async{
    Dio dio=Dio();
    Response response;

    AuthInterceptor interceptor=AuthInterceptor(dio);

    dio.interceptors.add(interceptor);
    
    response=await dio.get(
      "http://31.184.254.86:9099/api/v1/car/model",
      queryParameters: {
        "name":text,
        "manufacturer_id":id
      }
    );
      List<CarModel> carModels = [];
      List<dynamic> data = response.data["data"];
      carModels = data.map((item) => CarModel(item["id"], item["name"])).toList();
  
    return carModels;
  }

}