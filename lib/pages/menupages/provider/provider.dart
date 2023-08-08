


import 'package:flutter/foundation.dart';


class DopInfo{
 int countPassanger=3;
 bool baggage=false;
 bool childPassanger=false;
 bool animal =false;
 bool smoking=false;
 String comment="";
 DopInfo(this.countPassanger,this.baggage,this.childPassanger,this.animal,this.smoking,this.comment);
}

class DataCreate{
  String city;
  String state;
  String fullAdress;
  double longitude;
  double latitude;
  int? cityId;
  DataCreate(this.city,this.state, this.latitude,this.longitude,this.fullAdress,[this.cityId]);
}

class CarModel{
  int id;
  String name;
  CarModel(this.id,this.name);
}
class CarData{
  CarModel model;
  CarModel name;
  int year=0;
  String carNumber;
  CarData(this.name,this.model,this.carNumber,this.year);
}


class CreateProvider with ChangeNotifier {


  String _price ="";
  CarData _car = CarData(CarModel(-1,""), CarModel(-1,""), "", 0);
  DopInfo _dopInfo =DopInfo(3,false, false, false, false, "");
  
//getters

  String get price=>_price;
  CarData get car=>_car;
  DopInfo get dopInfo=>_dopInfo;

//setters

  void setPrice(String price) {
    _price = price;
    notifyListeners();
  }
  void setCar(CarData car){
    _car=car;
    notifyListeners();
  }
 
  void setDopInfo(DopInfo dopInfo){
    _dopInfo=dopInfo;
    notifyListeners();
  }
}


class SearchProvider with ChangeNotifier {

  DataCreate _from =DataCreate("","",0,0,"");
  DataCreate _to =DataCreate("","",0,0,"");
  String _price ="";
  
//getters
  DataCreate get from => _from;
  DataCreate get to => _to;
  String get price=>_price;

//setters
  void setFrom(DataCreate from) {
    _from = from;
    notifyListeners();
  }
  void setTo(DataCreate to) {
    _to = to;
    notifyListeners();
  }
  void setPrice(String price) {
    _price = price;
    notifyListeners();
  }
}


