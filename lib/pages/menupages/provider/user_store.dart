
import 'package:flutter_application_1/http/user/http_user.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  UserData userInfo=UserData(
    auth: false,
      clienId: -1,
      dateOfBirth: 0, 
      gender:"", 
      name: "", 
      nickname: "", 
      photo: "", 
      surname: ""
  );

  @action
  Future setUserInfo()async {
     UserData? userData=await HttpUser().getUser();
     print("userData");
     print(userData);
     if(userData!=null){
      userInfo=userData;
     }
  }
}


UserStore userStore=UserStore();