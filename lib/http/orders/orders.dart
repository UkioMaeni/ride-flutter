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
const baseAppUrl="http://31.184.254.86:9099/api/v1/";
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
  String comment;
  Preferences preferences;
  RideInfo({
    required this.comment,
    required this.price,
    required this.numberOfSeats,
    required this.preferences
  });

  Map<String,dynamic> toJson(){
    return {
      "comment":comment,
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

class Automobile {

  String model;
  String manufacturer;
  String number;
  String year;
  Automobile({
    required this.model,
    required this.manufacturer,
    required this.number,
    required this.year
  });
}

class UserOrderFullInformation extends DriverOrder{
  List<Travelers> travelers;
  List<Location> location;
  String? comment;
  bool isBooked;
  int? driverId;
  bool isDriver;
  Automobile automobile;
  UserOrderFullInformation({
    required this.isDriver,
    required this.automobile,
    this.driverId,
    this.comment,
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
    required this.location,
    required this.isBooked
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
  int? clientReservedSeats;
  int bookedStatus;
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
    this.clientReservedSeats,
    required this.bookedStatus,
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
    if(response.data["data"]==null){
      return [];
    }
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
      bookedStatus: el["booked_status"]??-1,
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
    return driverOrder;
    } catch (e) {
      print(e);
      return [];
    }
  }


 Future<List<DriverOrderFind>> findUserOrderByOtherCity(int startPoint,int endPoint,int numberOfSeats,int date)async{
    String access= await TokenStorage().getToken("access");
    if(access=="no") return [];
    try {
      Response response = await dio.get(
    baseUrlFindOrder+"-nearest",
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
    print("OTHER");
    inspect(response.data); 
    if (response.data["data"]==null)
      return [];
     
    List<dynamic> orders=response.data["data"];
    driverOrder=orders.map((el) =>DriverOrderFind(
      bookedStatus: el["booked_status"]??-1,
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
    return driverOrder;
    } catch (e) {
      print(e);
      return [];
    }
  }


  Future<List<int>> findUserSimilarOrder(int startPoint,int endPoint,int numberOfSeats,int date)async{
    String access= await TokenStorage().getToken("access");
    if(access=="no") return [];
    print('similar ${date}');
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
      inspect(_mapResponse);
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
      isDriver: _mapResponse["is_driver"],
      driverId: _mapResponse["driver_id"],
      comment: _mapResponse["comment"],
      orderId: _mapResponse["order_id"], 
      clientAutoId: _mapResponse["client_auto_id"], 
      departureTime: _mapResponse["departure_time"],
      nickname: _mapResponse["nickname"], 
      status: _mapResponse["status"], 
      startCountryName: "", 
      endCountryName: "",
      automobile: Automobile(
        model: _mapResponse["automobile"]["model"], 
        manufacturer: _mapResponse["automobile"]["manufacturer"], 
        number: _mapResponse["automobile"]["number"], 
        year: _mapResponse["automobile"]["year"]
        ), 
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
      travelers: _travelers,
      isBooked: _mapResponse["is_booked"]
      );
      return fullOrderInfo;
    } catch (e) {
       print(e);
      return null;
     
    }
  }

  Future<int> orderBook(int orderId,int seats )async{
    String access= await TokenStorage().getToken("access");
    try {
      Response response=await dio.post(
        baseAppUrl+"order/book",
        data: {
          "order_id":orderId,
          "number_of_reserved_seats":seats
        },
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print(response.data);
      return 0;
    } catch (e) {
      return 1;
    }
  }

  Future<int> orderCancel(int orderId)async{
    String access= await TokenStorage().getToken("access");
    try {
      Response response=await dio.put(
        baseAppUrl+"order-app/cancel/"+orderId.toString(),
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print(response.data);
      return 0;
    } catch (e) {
      return 1;
    }
  }
    Future<int> orderDriverCancel(int orderId,String comment)async{
    String access= await TokenStorage().getToken("access");
    try {
      Response response=await dio.put(
        baseAppUrl+"order/cancel",
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          },
         
        ),
         data:{
          "order_id":orderId,
          "comment":""
         }
      );
      print("cancel");
      print(response.data);
      return 0;
    } catch (e) {
      print(e);
      return 1;
    }
  }

  Future<List<DriverOrderFind>> myTrips()async{
    String access= await TokenStorage().getToken("access");
    try {
      Response response=await dio.get(
        baseAppUrl+"client/orders/booked",
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
     
    List<DriverOrderFind> driverOrder=[];
    List<dynamic> orders=response.data["data"];
    driverOrder=orders.map((el) =>DriverOrderFind(
      clientReservedSeats: el["client_reserved_seats"],
      bookedStatus: el["booked_status"],
      orderId: el["order_id"], 
      driverId: el["driver_id"],
      driverCar: el["driver_car"]??"", 
      departureTime: el["departure_time"],
      nickname: el["driver_nickname"]??"error", 
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
      
      return driverOrder;
      
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int> editDriverOrder(int carId, int seats,String comment,Preferences preferences,int orderId)async{
    String access= await TokenStorage().getToken("access");
    try {

      Response response=await dio.put(
        "${baseAppUrl}order/$orderId",
        data: {
          "car_id":carId,
          "number_of_seats":seats,
          "comment":comment,
          "preference":preferences.toJson()
        },
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print(response.data);
      return 0;
    } catch (e) {
      print(e);
      return 1;      
    }
  }

  Future<int> deleteUserInOrder(int orderId,int clientId)async{
    String access= await TokenStorage().getToken("access");
        try {
          Response response=await dio.delete(
        "${baseAppUrl}order/client",
        data: {
          "order_id":orderId,
          "client_id":clientId,
          "comment":"",
        },
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print(response.data);
      return 0;
        } catch (e) {
          print(e);
          return -1;
        }
  }
}