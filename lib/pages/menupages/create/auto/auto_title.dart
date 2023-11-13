import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/user/http_user_car.dart';
import 'package:flutter_application_1/pages/UI/barNavigation/barNavigation.dart';
import 'package:flutter_application_1/pages/menupages/create/auto/auto.dart';
import 'package:flutter_application_1/pages/menupages/create/card_car/card_car.dart';
import 'package:flutter_application_1/pages/menupages/create/dop_options/dop_options.dart';
import 'package:flutter_application_1/pages/menupages/create/enumMap/enum_map.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/provider/store.dart';
import 'package:flutter_svg/flutter_svg.dart';

final Preferences defaultPreferences=Preferences(smoking: false, luggage: false, childCarSeat: false, animals: false);
final int defaultcountPass=4;



class AutoTitle extends StatefulWidget{
  const AutoTitle({required this.side, super.key});

  final Function side;

  @override
  State<AutoTitle> createState() => _AutoTitleState();
}

class _AutoTitleState extends State<AutoTitle> {
  CarData car = CarData(CarModel(-1,""),CarModel(-1,"") , "", 0);

  

  late TextEditingController _numberController;
  late TextEditingController _yearController;

  @override
  void dispose() {
    _yearController.dispose();
    _numberController.dispose();
    super.dispose();
  }

@override
  void initState() {
    _yearController =TextEditingController();
  _numberController =TextEditingController();
    super.initState();
  }

  updateModel(CarModel newModel){
    print(newModel.id);
      setState(() {
        car.model=newModel;
      });
  }

  updateName(CarModel newName){
    print(newName.id);
      setState(() {
        car.name=newName;
      });
  }

  updateCarNumber(String newNumber){
      setState(() {
        car.carNumber=newNumber;
      });
  }

  updateYear(int newYear){
      setState(() {
        car.year=newYear;
      });
  }
bool clicked=false;
  bool validManufacturer=true;
  bool validModel=true; 
  bool validNumber=true;
  bool validYear=true;
  @override
  Widget build(BuildContext context) {

  //validation


checked(){
     if(car.name.name.isEmpty&&clicked){
      validManufacturer=false;
    }else{
      validManufacturer=true;
    }
     if(car.model.name.isEmpty&&clicked){
        validModel=false;
    }else{
      validModel=true;
    }
     if(_numberController.text.isEmpty&&clicked){
        validNumber=false;
    }else{
      validNumber=true;
    }
     if(_yearController.text.isEmpty&&clicked){
     
        validYear=false;
    }else{
      validYear=true;
    }
}
   
checked();
print("$validManufacturer nnnumbeer");
    void checkValid(){
      clicked=true;
      checked();
      
   if(validManufacturer&&validModel&&validNumber&&validYear){
    print("CONTACT");
      updateCarNumber(_numberController.text);
                                               updateYear(int.parse(_yearController.text));       
                                               storeApp.setCar(car);

                                               Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DopOptions(side: widget.side, count: defaultcountPass,preferences: defaultPreferences,carId: -1,)),
                                );
    }
    setState(() {
      
    });
 }
  
    return Padding(
          padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
          child: Column(
            
            children: [
              BarNavigation(back: true, title: "Car selection"),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                          CardCar(update: updateName, types: MyEnum.name,title:car.name.name,other: CarModel(-1, "_"),valid:validManufacturer),
                CardCar(update: updateModel, types: MyEnum.model,title:car.model.name,other: car.name,valid:validModel),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.center,
                    
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: categorySelected,
                    border: Border.all(
                        color: validNumber?Color.fromRGBO(237, 238, 243, 1):Colors.red
                      )
                  ),
                  child: TextField(
                    controller: _numberController,
                    style: TextStyle(
                      fontFamily: "SF",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: brandBlack
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "State number of the car",
                      counterText: ""
                    ),
                    inputFormatters: [
                      UpperCaseTextFormatter()
                    ],
                      maxLength: 10,
                      textCapitalization: TextCapitalization.sentences
                  ),
                            ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: categorySelected,
                   border: Border.all(
                        color: validYear?Color.fromRGBO(237, 238, 243, 1):Colors.red
                      )
                ),
                child: TextField(
                  controller: _yearController,
                   style: TextStyle(
                      fontFamily: "SF",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: brandBlack
                    ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Year of manufacture of the car",
                    counterText: ""
                  ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    maxLength: 4,
                ),
                          ),
                      ],
                    ),
                          Positioned(
                            bottom: 32,
                            left: 0,
                            right: 0,
                            child: InkWell(
                                              onTap: (){
                                                checkValid();
                                               
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
              ),
              
          
            ],
          ),
        );
  }
}