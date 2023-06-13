import 'package:ezride/http/cars/car_model.dart';
import 'package:ezride/pages/mainapp/menupages/create/auto/auto.dart';
import 'package:ezride/pages/mainapp/menupages/search/search.dart';
import 'package:flutter/foundation.dart';
////CreateProvider


class DopInfo{
 int countPassanger=3;
 bool baggage=false;
 bool childPassanger=false;
 bool animal =false;
 bool smoking=false;
 String comment="";
 DopInfo(this.countPassanger,this.baggage,this.childPassanger,this.animal,this.smoking,this.comment);
}

class CreateProvider with ChangeNotifier {

  DataCreate _from =DataCreate("from",0,0);
  DataCreate _to =DataCreate("to",0,0);
  String _price ="";
  CarData _car = CarData(CarModel(-1,""), CarModel(-1,""), "", 0);
  DopInfo _dopInfo =DopInfo(3,false, false, false, false, "");
  
//getters
  DataCreate get from => _from;
  DataCreate get to => _to;
  String get price=>_price;
  CarData get car=>_car;
  DopInfo get dopInfo=>_dopInfo;

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
  void setCar(CarData car){
    _car=car;
    notifyListeners();
  }
 
  void setDopInfo(DopInfo dopInfo){
    _dopInfo=dopInfo;
    notifyListeners();
  }
}