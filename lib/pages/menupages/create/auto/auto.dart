
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/user/http_user_car.dart';
import 'package:flutter_application_1/pages/UI/barNavigation/barNavigation.dart';
import 'package:flutter_application_1/pages/menupages/create/auto/auto_title.dart';
import 'package:flutter_application_1/pages/menupages/create/dop_options/dop_options.dart';
import 'package:flutter_application_1/pages/menupages/provider/store.dart';
import 'package:flutter_svg/flutter_svg.dart';






class Auto extends StatefulWidget{
  final Function side;
  const Auto({required this.side, super.key});

  @override
  State<Auto> createState() => _AutoState();
}

class _AutoState extends State<Auto> {


  @override
  void initState() {
   storeApp.setCreatAuto(true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            toolbarOpacity: 0,
            elevation: 1,
            
        ),
        body: FutureBuilder<List<UserCar>>(
      future: HttpUserCar().getUserCar(),
      builder: (context, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator()
            );
        }
        if(snapshot.hasError){
            return Center(
              child: Text("Ошибка"),
            );
        }
        List<UserCar>? userCar=  snapshot.data;
        print(userCar);
          if(userCar!.isEmpty){
            return  AutoTitle(
              side:widget.side
            );
          }
          return Column(
            children: [
              BarNavigation(back: true, title: "Какой авто"),
              Expanded(
                child: ListView.builder(
                    itemCount: userCar.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                                onTap:(){
                                  storeApp.setCreatAuto(false);
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => DopOptions(
                                        side: widget.side,
                                        preferences:userCar[index].preferences,
                                        count:userCar[index].numberOfSeats,
                                        carId:userCar[index].carId
                                        ),
                                      ));
                                },
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: categorySelected,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15,right: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Text(
                                            "${userCar[index].manufacturer} ${userCar[index].model}",
                                            style: const TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(87,87,88,1)
                                            ),
                                          ),
                                        SvgPicture.asset("assets/svg/upToMap.svg")
                                      ],
                                    ),
                                  ),
                                ),
                              );
                    },
                    ),
              ),
                
            ],
          );
      },
      )
    );
  }
}


///хелперы 
///
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

