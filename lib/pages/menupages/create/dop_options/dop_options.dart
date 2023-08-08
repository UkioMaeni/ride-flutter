

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/http/user/http_user_car.dart';
import 'package:flutter_application_1/pages/UI/barNavigation/barNavigation.dart';
import 'package:flutter_application_1/pages/menupages/create/price/price.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/provider/store.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DopOptions extends StatefulWidget {
  final Function side;
  final Preferences preferences;
  final int count;
  final int carId;
  const DopOptions({required this.side, required this.preferences,required this.count,required this.carId, super.key});

  @override
  State<DopOptions> createState() => _DopOptionsState();
}

class _DopOptionsState extends State<DopOptions> {

  TextEditingController myController = TextEditingController();

  ////////////////////////answer options
  late int count;
  //countPassanger:
  late int countPassanger;
  setCountPassanger(int value) {
    setState(() {
      countPassanger = value;
    });
  }
  //baggage:
  late int baggage;
  setBaggage(int value) {
    setState(() {
      baggage = value;
    });
  }
  //childPassanger:
  late int childPassange;
  setChildPassange(int value) {
    setState(() {
      childPassange = value;
    });
  }
  //animalRide:
  late int animalRide;
  setAnimalRide(int value) {
    setState(() {
      animalRide = value;
    });
  }
  //smoking:
  late int smoking;
  setSmoking(int value) {
    setState(() {
      smoking = value;
    });
  }
    @override
  void initState() {
    count=widget.count;
    countPassanger=widget.count;
    animalRide=widget.preferences.animals?1:2;
    childPassange=widget.preferences.childCarSeat?1:2;
    baggage=widget.preferences.luggage?1:2;
    smoking=widget.preferences.smoking?1:2;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        toolbarOpacity: 0,
        elevation: 1,
      ),
      body:Column(
        children: [
        BarNavigation(back: true, title: "Доп"),
Expanded(
  child:   ListView(
  
          padding: const EdgeInsets.symmetric(horizontal: 16),

          children: [
 
            Container(  
              padding: const EdgeInsets.only( bottom: 8),  
              child: Text(
  
                "Выберите",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
                for(int i =0;i<count;i++) pointAnswer(i+1, countPassanger, "${i+1}", setCountPassanger),
              ],
  
            ),
  
            Container(
  
              padding: const EdgeInsets.only(top: 24, bottom: 8),
  
              child: Text(
  
                "Перевозка",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
  
                pointAnswer(1, baggage, "Yes", setBaggage),
  
                const SizedBox(width: 8),
  
                pointAnswer(2, baggage, "No", setBaggage),
  
              ],
  
            ),
  
            Container(
  
              padding: const EdgeInsets.only(top: 24, bottom: 8),
  
              child: Text(
  
                "Детское кресло",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
  
                pointAnswer(1, childPassange, "Yes", setChildPassange),
  
                const SizedBox(width: 8),
  
                pointAnswer(2, childPassange, "No", setChildPassange),
  
              ],
  
            ),
  
            Container(
  
              padding: const EdgeInsets.only(top: 24, bottom: 8),
  
              child: Text(
  
                "Животные",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
  
                pointAnswer(1, animalRide, "Yes", setAnimalRide),
  
                const SizedBox(width: 8),
  
                pointAnswer(2, animalRide, "No", setAnimalRide),
  
              ],
  
            ),
  
            Container(  
              padding: const EdgeInsets.only(top: 24, bottom: 8),  
              child: Text(  
                "Курение",  
                style: currentTextStyle,  
              ), 
            ),
            Row(
              children: [
                pointAnswer(1, smoking, "Yes", setSmoking),
                const SizedBox(width: 8),
                pointAnswer(2, smoking, "No", setSmoking),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              child: Text(
                "Коммент",
                style: currentTextStyle,
              ),
            ),
           Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color.fromRGBO(173, 179, 188, 1)),
            ),
            child:  TextField(
                style: currentTextStyle,
                controller: myController,
                decoration: const InputDecoration(
                  
                  contentPadding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                  border: InputBorder.none,
                  hintText: "Как поедете, планируете ли остановки, правила поведения в машине и т.д.",
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            
),
        Padding(
              padding: const EdgeInsets.only(top:32),
              child: InkWell(
                onTap: (){
                  bool baggage_=baggage==1?true:false;
                  bool childPassange_=childPassange==1?true:false;
                  bool animal_=animalRide==1?true:false;
                  bool smoking_=smoking==1?true:false;
                  DopInfo dopInfo=DopInfo(countPassanger,baggage_,childPassange_,animal_,smoking_,myController.text);
                  storeApp.setDopInfo(dopInfo);
                  print(storeApp.dopInfo.animal);
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context)=> Price(
                        side:widget.side,
                        carId:widget.carId,
                      ),
                      )
                      );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:const Color.fromRGBO(64,123,255,1),
                    borderRadius: BorderRadius.circular(10)
                    
                  ),
                  child: const Text(
                    "Продолжить",
                    style: TextStyle(
                      color: Color.fromRGBO(255,255,255,1),
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
      ) 
    );
  }
}

Widget pointAnswer(dynamic index, dynamic currentIndex, String text, Function setIndex) {
  return GestureDetector(
    onTap: () {
      setIndex(index);
    },
    child: Row(
      children: [
        Container(
          width: 56,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
                color: index == currentIndex
                    ? const Color.fromRGBO(64, 123, 255, 1)
                    : const Color.fromRGBO(173, 179, 188, 1)),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: currentTextStyle.copyWith(
                color: const Color.fromRGBO(85, 85, 85, 1),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    ),
  );
}

TextStyle currentTextStyle = const TextStyle(
  fontFamily: "Poppins",
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Color.fromRGBO(51, 51, 51, 1),
);