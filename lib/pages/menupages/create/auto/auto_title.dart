import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/pages/menupages/create/auto/auto.dart';
import 'package:flutter_application_1/pages/menupages/create/card_car/card_car.dart';
import 'package:flutter_application_1/pages/menupages/create/dop_options/dop_options.dart';
import 'package:flutter_application_1/pages/menupages/create/enumMap/enum_map.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/provider/store.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AutoTitle extends StatefulWidget{
  const AutoTitle({super.key});

  @override
  State<AutoTitle> createState() => _AutoTitleState();
}

class _AutoTitleState extends State<AutoTitle> {



  late TextEditingController _yearController;
  late TextEditingController _numberController;


  CarData car = CarData(CarModel(-1,""),CarModel(-1,"") , "", 0);

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
@override
  void initState() {
    _yearController =TextEditingController();
  _numberController =TextEditingController();
    super.initState();
  }




  @override
  void dispose() {
    _yearController.dispose();
    _numberController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
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
              CardCar(update: updateName, types: MyEnum.name,title:car.name.name,other: CarModel(-1, "_"),),
              CardCar(update: updateModel, types: MyEnum.model,title:car.model.name,other: car.name,),
              Padding(
                padding: const EdgeInsets.only(top: 12,bottom: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: categorySelected
                ),
                child: TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Номер",
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
                color: categorySelected
              ),
              child: TextField(
                controller: _yearController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Год выпуска",
                  counterText: ""
                ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  maxLength: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:12),
              child: InkWell(
                onTap: (){
                 updateCarNumber(_numberController.text);
                 updateYear(int.parse(_yearController.text));       
                 storeApp.setCar(car);
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DopOptions()),
                          );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:car.name.id!=-1&&car.model.id!=-1&&_numberController.text.isNotEmpty? const Color.fromRGBO(64,123,255,1) : const Color.fromRGBO(177,177,177,0.5),
                    borderRadius: BorderRadius.circular(10)
                    
                  ),
                  child: Text(
                    "Продолжить",
                    style: TextStyle(
                      color:car.name.id!=-1&&car.model.id!=-1&&_numberController.text.isNotEmpty? const Color.fromRGBO(255,255,255,1):const Color.fromRGBO(255,255,255,0.5),
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
}