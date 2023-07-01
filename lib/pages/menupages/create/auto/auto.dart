
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/user/http_user_car.dart';
import 'package:flutter_application_1/pages/menupages/create/auto/auto_title.dart';
import 'package:flutter_application_1/pages/menupages/create/dop_options/dop_options.dart';
import 'package:flutter_svg/flutter_svg.dart';






class Auto extends StatefulWidget{
  const Auto({super.key});

  @override
  State<Auto> createState() => _AutoState();
}

class _AutoState extends State<Auto> {

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
            return  AutoTitle();
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40,top:20),
                child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                              "assets/svg/back.svg",
                              height: 12,
                              width: 6,
                                  ),
                            ),
                          ),
                          const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Какой авто",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: userCar.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                                onTap:(){
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => DopOptions(
                                        // userCar[index].numberOfSeats, 
                                        // userCar[index].preferences.luggage, 
                                        // userCar[index].preferences.childCarSeat, 
                                        // userCar[index].preferences.animals, 
                                        // userCar[index].preferences.smoking, 
                                        // ""
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

