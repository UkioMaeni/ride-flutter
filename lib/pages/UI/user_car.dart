import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/user/http_user_car.dart';
import 'package:flutter_application_1/pages/UI/barNavigation/barNavigation.dart';
import 'package:flutter_application_1/pages/menupages/create/card_order/card_order_redact/UI/variable_car.dart';
import 'package:flutter_application_1/pages/menupages/create/card_order/card_order_redact/models/variables_user_car.dart';

class UserAutoUI extends StatefulWidget{
  const UserAutoUI({super.key});

  @override
  State<UserAutoUI> createState() => _UserAutoUIState();
}

class _UserAutoUIState extends State<UserAutoUI> {

int currentCar=0;

 @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Column(
        children: [
          BarNavigation(back: true, title: "My cars"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: variableAuto()
              ),
          ),
          Padding(
                            padding: EdgeInsets.only(bottom: 25,left: 15,right: 15),
                            child: InkWell(
                                              onTap: (){
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: double.infinity,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color:brandBlue,
                                                  borderRadius: BorderRadius.circular(10)
                                                  
                                                ),
                                                child: Text(
                                                  "Continue",
                                                  style: TextStyle(
                            color:Colors.white,
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ),
                                            
                              
                                          ),
                          )
        ],
      ),
    );
  }

  Widget variableAuto(){
    return FutureBuilder(
        future: HttpUserCar().getUserCar(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text("error");
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Column(
              children: [
                ShimmerVariableCar(),
                
              ],
            );
          }
          List<UserCar> usercars=snapshot.data!;
          if(usercars.isEmpty){
            return  Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/image/cars_empty.png"),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 16),
                      child: Text(
                            "You don't have any cars added yet. Add your first vehicle and start benefiting from using our app!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              
                              color: brandBlack,
                              fontFamily: "SF",
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                    ),
                  ],
                ),
              
            );
          }
          currentCar=usercars[0].carId;
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for(int i=0;i<usercars.length;i++) 
                  VariableCar( pressed: currentCar==usercars[i].carId,userCar:usercars[i]),
                Text(
                  "+ add car",
                  style: TextStyle(
                    color: brandBlue,
                    fontFamily: "SF",
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
          );
          
        },
        );
  }
}