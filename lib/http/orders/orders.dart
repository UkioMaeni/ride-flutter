import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/http/user/http_user_car.dart';
import 'package:flutter_application_1/tokenStorage/token_storage.dart';

const baseUrl="http://31.184.254.86:9099/api/v1/order";
const baseUrlDriver="http://31.184.254.86:9099/api/v1/driver/orders";
class UserOrder{
  int clientAutoId; 
  RideInfo rideInfo;
  Preferences preferences;
  List<Location> locations;

  UserOrder({
    required this.clientAutoId,
    required this.rideInfo,
    required this.preferences,
    required this.locations
  });

  Map<String,dynamic> toJson(){
    return {
      "client_auto_id":clientAutoId,
      "ride_info":rideInfo.toJson(),
      "payment_info":{"type":1 },
      "preferences":preferences.toJson(),
      "locations":locations.map((loc) =>loc.toJson()).toList()
    };
  }
}

 class Location{
   int cityId;
   int sortId;
   bool pickUp;
   String location;
   double longitude;
   double latitude;
   int departureTime;
   Location({
    required this.cityId,
    required this.sortId,
    required this.pickUp,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.departureTime
   });

   Map<String,dynamic> toJson(){
    return {
      "city_id":cityId,
      "sort_id":sortId,
      "pick_up":pickUp,
      "location":location,
      "longitude":longitude,
      "latitude":latitude,
      "departure_time":departureTime
    };
   }
  }

class RideInfo{
  double price;
  int numberOfSeats;
  RideInfo({
    required this.price,
    required this.numberOfSeats
  });

  Map<String,dynamic> toJson(){
    return {
      "price":price,
      "number_of_seats":numberOfSeats
    };
  }
}
/////driver/orders
class SeatsInfo{
  int total;
  int reserved;
  int free;
  SeatsInfo({
    required this.total,
    required this.reserved,
    required this.free
  });
}

class DriverOrder{
  int orderId;
  int clientAutoId;
  int departureTime;
  String nickname;
  String status;
  String startCountryName;
  String endCountryName;
  SeatsInfo seatsInfo;
  int numberOfApps;
  double price;
  Preferences preferences;
  DriverOrder({
    required this.orderId,
    required this.clientAutoId,
    required this.departureTime,
    required this.nickname,
    required this.status,
    required this.startCountryName,
    required this.endCountryName,
    required this.seatsInfo,
    required this.numberOfApps,
    required this.price,
    required this.preferences
  });
}

class HttpUserOrder{
 
  Dio dio=Dio();
  HttpUserOrder(){
    final authInterceptor = AuthInterceptor(dio);
    dio.interceptors.add(authInterceptor);
  }

 Future<int> createUserOrder(UserOrder userOrder)async{

  String access= await TokenStorage().getToken("access");
  if(access=="no") return -1;
  print(userOrder.toJson());
  try{
   Response response = await dio.post(
    baseUrl,
    data: userOrder.toJson(),
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

   Future<List<DriverOrder>> getUserOrders()async{
    String access= await TokenStorage().getToken("access");
    if(access=="no") return [];
    print(access);
    try {
      Response response = await dio.get(
    baseUrlDriver,
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );
    print("respon");
    print(response.data);
    List<DriverOrder> driverOrder=[];
    List<dynamic> orders=response.data["data"];
    driverOrder=orders.map((el) =>DriverOrder(
      orderId: el["order_id"], 
      clientAutoId: el["client_auto_id"], 
      departureTime: el["departure_time"],
      nickname: el["nickname"], 
      status: el["status"], 
      startCountryName: el["start_country_name"], 
      endCountryName: el["end_country_name"], 
      seatsInfo: SeatsInfo(
        total: el["seats_info"]["total"], 
        reserved: el["seats_info"]["reserved"], 
        free: el["seats_info"]["free"]
      ), 
      numberOfApps: el["number_of_apps"], 
      price:el["price"]+0.0 , 
      preferences: Preferences(
        smoking: el["preference"]["smoking"], 
        luggage: el["preference"]["luggage"], 
        childCarSeat: el["preference"]["child_car_seat"], 
        animals: el["preference"]["animals"]
        )
      )).toList();
       print(driverOrder);
    return driverOrder;
    } catch (e) {
      print(e);
      return [];
    }
  }

 
}