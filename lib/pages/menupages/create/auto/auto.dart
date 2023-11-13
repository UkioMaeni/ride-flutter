
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/user/http_user_car.dart';
import 'package:flutter_application_1/pages/UI/barNavigation/barNavigation.dart';
import 'package:flutter_application_1/pages/menupages/create/auto/auto_title.dart';
import 'package:flutter_application_1/pages/menupages/create/card_order/card_order_redact/UI/variable_car.dart';
import 'package:flutter_application_1/pages/menupages/create/card_order/card_order_redact/models/variables_user_car.dart';
import 'package:flutter_application_1/pages/menupages/create/dop_options/dop_options.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/provider/store.dart';
import 'package:flutter_svg/flutter_svg.dart';






class Auto extends StatefulWidget{
  final Function side;
  const Auto({required this.side, super.key});

  @override
  State<Auto> createState() => _AutoState();
}

class _AutoState extends State<Auto> {

 Widget currentWidget=Center(child: CircularProgressIndicator());

  int currentautoId=0;
List<UserCar> userCar=[];
  @override
  void initState() {
   storeApp.setCreatAuto(true);
   HttpUserCar().getUserCar().then((value){
    if(value.isEmpty){
            setState(() {
              currentWidget=  AutoTitle(
                  side:widget.side
                );
            });
                
              }else{
                  setState(() {
                    userCar=value;
                    currentautoId=userCar[0].carId;
                  });
              }
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int carIndex = userCar.indexWhere((element) => element.carId==currentautoId);
    return Scaffold(
      appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            toolbarOpacity: 0,
            elevation: 1,
            
        ),
        body:userCar.length==0
        ?currentWidget
        : Padding(
         padding: const EdgeInsets.only(left: 0,right: 0),
         child:  Column(
           children: [
               BarNavigation(back: true, title: "My cars"),
             Expanded(
               child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                 child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                             
                                for(int i=0;i<userCar.length;i++) 
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                     setState(() {
                                        currentautoId=userCar[i].carId;
                                        print(currentautoId);
                                     });
                                    },
                                    child: VariableCar( pressed: currentautoId==userCar[i].carId,userCar:userCar[i])
                                    ),
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
                          ),
                          Padding(
                                     padding: EdgeInsets.only(bottom: 32),
                                      child: InkWell(
                                                        onTap: (){
                                                       storeApp.createAuto=false;
                                                          Navigator.push(
                                                            context, 
                                                            MaterialPageRoute(builder: (context) => DopOptions(side: widget.side, preferences: userCar[carIndex].preferences , count: userCar[carIndex].numberOfSeats, carId: currentautoId),)
                                                            );
                                                         
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
                                      fontFamily: "SF",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                                            ),
                                                          ),
                                                        ),
                                                      
                                        
                                                    ),
                                    
                          )
                     ],
                   ),
               ),
             ),
           ],
         ),
         
       )
           
    );
  }
}



///
///
///
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

