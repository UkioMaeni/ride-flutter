import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/http/user/http_user_car.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';
import 'package:flutter_application_1/pages/menupages/profile/profile.dart';

const baseUrl="http://31.184.254.86:9099/api/v1/order";
const baseUrlDriver="http://31.184.254.86:9099/api/v1/driver/orders";
const baseUrlFindOrder="http://31.184.254.86:9099/api/v1/orders/find";
const baseUrlFindOrderInId="http://31.184.254.86:9099/api/v1/order";
class UserOrder{
  int clientAutoId; 
  RideInfo rideInfo;
  List<Location> locations;

  UserOrder({
    required this.clientAutoId,
    required this.rideInfo,
    required this.locations
  });

  Map<String,dynamic> toJson(){
    return {
      "client_auto_id":clientAutoId,
      "ride_info":rideInfo.toJson(),
      "payment_info":{"type":1 },
      "locations":locations.map((loc) =>loc.toJson()).toList()
    };
  }
}

 class Location{
   String city;
   String state;
   int sortId;
   bool pickUp;
   String location;
   double longitude;
   double latitude;
   int departureTime;
   Location({
    required this.city,
    required this.state,
    required this.sortId,
    required this.pickUp,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.departureTime
   });

   Map<String,dynamic> toJson(){
    return {
      "city":city,
      "state":state,
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
  Preferences preferences;
  RideInfo({
    required this.price,
    required this.numberOfSeats,
    required this.preferences
  });

  Map<String,dynamic> toJson(){
    return {
      "price":price,
      "number_of_seats":numberOfSeats,
      "preferences":preferences.toJson()
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
    required this.price,
    required this.preferences
  });
}
class UserOrderFullInformation extends DriverOrder{
  List<Travelers> travelers;
  List<Location> location;
  UserOrderFullInformation({
    required super.orderId, 
    required super.clientAutoId, 
    required super.departureTime, 
    required super.nickname, 
    required super.status, 
    required super.startCountryName, 
    required super.endCountryName, 
    required super.seatsInfo, 
    required super.price, 
    required super.preferences,
    required this.travelers,
    required this.location
    });
  
}
class Travelers{
  int userId;
  String nickname;
  Travelers({
    required this.userId,
    required this.nickname
  });
}
class PointLocation{
  String city;
  double latitude;
  double longitude;
  PointLocation({
    required this.city,
    required this.latitude,
    required this.longitude
  });
}
class DriverOrderFind{
  int orderId;
  int driverId;
  String driverCar;
  int departureTime;
  String nickname;
  PointLocation startPoint;
  PointLocation endPoint;
  double price;
  Preferences preferences;
  SeatsInfo seatsInfo;
  DriverOrderFind({
    required this.orderId,
    required this.driverId,
    required this.driverCar,
    required this.departureTime,
    required this.nickname,
    required this.startPoint,
    required this.endPoint,
    required this.price,
    required this.preferences,
    required this.seatsInfo
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

  Future<List<DriverOrderFind>> findUserOrder(int startPoint,int endPoint,int numberOfSeats,int date)async{
    String access= await TokenStorage().getToken("access");
    if(access=="no") return [];
    print(access);
    print(DateTime.fromMillisecondsSinceEpoch(date*1000).toString());
    try {
      Response response = await dio.get(
    baseUrlFindOrder,
    queryParameters: {
      "start_point":startPoint,
      "end_point":endPoint,
      "number_of_seats":numberOfSeats,
      "date":date

    },
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );

    List<DriverOrderFind> driverOrder=[];
    inspect(response.data); 
    if (response.data["data"]==null)
      return [];
     
    List<dynamic> orders=response.data["data"];
    driverOrder=orders.map((el) =>DriverOrderFind(
      orderId: el["order_id"], 
      driverId: el["driver_id"],
      driverCar: el["driver_car"], 
      departureTime: el["departure_time"],
      nickname: el["driver_nickname"], 
      startPoint:PointLocation(
        city: el["start_point"]["city"],
        longitude: el["start_point"]["longitude"],
        latitude: el["start_point"]["latitude"]
      ), 
      endPoint:PointLocation(
        city: el["end_point"]["city"],
        longitude: el["end_point"]["longitude"],
        latitude: el["end_point"]["latitude"]
      ),  
      seatsInfo: SeatsInfo(
        total: el["seats"]["total"], 
        reserved: el["seats"]["reserved"], 
        free: el["seats"]["free"]
      ), 
      price:el["order_price"]+0.0, 
      
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
      print(e);
      return [];
    }
  }

  Future<List<int>> findUserSimilarOrder(int startPoint,int endPoint,int numberOfSeats,int date)async{
    String access= await TokenStorage().getToken("access");
    if(access=="no") return [];
    print(access);
    try {
      Response response = await dio.get(
    "$baseUrlFindOrder-similar",
    queryParameters: {
      "start_point":startPoint,
      "end_point":endPoint,
      "number_of_seats":numberOfSeats,
      "date":date

    },
    options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
    );
      print(response.data);
      if(response.data["data"]==null){
        return [];
      }
      List<dynamic> list=response.data["data"];
      List<int> similarList=list.map<int>((e) => e as int).toList();
      return similarList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<UserOrderFullInformation?> getOrderInfo(int orderId)async{
    String access= await TokenStorage().getToken("access");
    try {
      Response response=await dio.get(
        baseUrlFindOrderInId+"/"+orderId.toString(),
        options: Options(
      headers: {
        "Authorization":"Bearer $access"
      }
    )
      );
      
      Map<String,dynamic> _mapResponse=response.data["data"];
      
      List<dynamic> _locationsResponse=_mapResponse["locations"];
      
     List<Location> _locations= _locationsResponse.map((el){
        return Location(
          city: el["city_name"], 
          state: el["state"], 
          sortId: el["sort_id"], 
          pickUp: el["pick_up"], 
          location: el["location"], 
          longitude: el["longitude"], 
          latitude:el ["latitude"], 
          departureTime: el["departure_time"]
          );
      }).toList();

      List<dynamic>? _travelersResponse=_mapResponse["travelers"];
      List<Travelers> _travelers;
      if(_travelersResponse==null){
          _travelers=[];
      }else{
        _travelers=_travelersResponse.map((el) {
        return Travelers(
          userId: el["id"], 
          nickname: el["nickname"]
          );
      },).toList();
      }
      
       

     final fullOrderInfo=  UserOrderFullInformation(
      orderId: _mapResponse["order_id"], 
      clientAutoId: _mapResponse["client_auto_id"], 
      departureTime: _mapResponse["departure_time"],
      nickname: _mapResponse["nickname"], 
      status: _mapResponse["status"], 
      startCountryName: "", 
      endCountryName: "", 
      seatsInfo: SeatsInfo(
        total: _mapResponse["seats_info"]["total"], 
        reserved: _mapResponse["seats_info"]["reserved"], 
        free: _mapResponse["seats_info"]["free"]
      ), 
      price:_mapResponse["price"]+0.0 , 
      preferences: Preferences(
        smoking: _mapResponse["preference"]["smoking"], 
        luggage: _mapResponse["preference"]["luggage"], 
        childCarSeat: _mapResponse["preference"]["child_car_seat"], 
        animals: _mapResponse["preference"]["animals"]
        ),
      location: _locations,
      travelers: _travelers
      );
      return fullOrderInfo;
    } catch (e) {
       print(e);
      return null;
     
    }
  }
}