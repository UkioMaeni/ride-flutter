import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:mobx/mobx.dart';
part 'store.g.dart';

class StoreController = ControllerBase with _$Controller;

abstract class ControllerBase with Store{
  @observable
  DateTime date=DateTime.now();
  @observable
  DataCreate from =DataCreate("dd",0,0,-1);
  @observable
  DataCreate to =DataCreate("",0,0,-1);
  @observable
  String price ="";
  @observable
  CarData car = CarData(CarModel(-1,""), CarModel(-1,""), "", 0);
  @observable
  DopInfo dopInfo =DopInfo(3,false, false, false, false, "");
  @action
  void setDate(DateTime date_) {
    date = date_;
  }
  @action
  void setFrom(DataCreate from_) {
    from = from_;
  }
  @action
  void setTo(DataCreate to_) {
    to = to_;
  }
  @action
  void setPrice(String price_) {
    price = price_;
  }
  @action
  void setCar(CarData car_){
    car=car_;
  }
  @action
  void setDopInfo(DopInfo dopInfo_){
    dopInfo=dopInfo_;
  }
}

final storeApp=StoreController();