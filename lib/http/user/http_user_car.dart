import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/tokenStorage/token_storage.dart';

const baseUrl="http://31.184.254.86:9099/api/v1/client/auto";

class ClientCar{
  int modelId;
  int manufacturerId;
  int numberOfSeats;
  String color="blue";
  String autoNumber;
  String year;
  Preferences preferences;
  ClientCar({
    required this.modelId,
    required this.manufacturerId,
    required this.numberOfSeats,
    required this.autoNumber,
    required this.year,
    required this.preferences
  });


  Map<String,dynamic> toJson(){
    return {
      "model_id":modelId,
      "manufacturer_id":manufacturerId,
      "number_of_seats":numberOfSeats,
      "color":color,
      "auto_number":autoNumber,
      "year":year,
      "preferences":preferences.toJson()
    };
  }
}

class Preferences{
  bool smoking;
  bool luggage;
  bool childCarSeat;
  bool animals;
  Preferences({
    required this.smoking,
    required this.luggage,
    required this.childCarSeat,
    required this.animals
  });

  Map<String,dynamic> toJson(){
    return {
      "smoking":smoking,
      "luggage":luggage,
      "child_car_seat":childCarSeat,
      "animals":animals
    };
  }
}

class HttpUserCar{
 
  Dio dio=Dio();
  HttpUserCar(){
    final authInterceptor = AuthInterceptor(dio);
    dio.interceptors.add(authInterceptor);
  }

 Future<int> createUserCar(ClientCar clientCar)async{

  String access= await TokenStorage().getToken("access");
  if(access=="no") return -1;

  try{
   Response response = await dio.post(
    baseUrl,
    data: clientCar.toJson(),
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );
    print(response.data);
    return 0;
  }catch(e){
    print(e);
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
    return {};
  }catch(e){
    return {};
  }
 }
}