
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/menupages/create/price/price.dart';
import 'package:flutter_application_1/pages/mainapp/create/provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DopOptions extends StatefulWidget {
  const DopOptions({super.key});

  @override
  State<DopOptions> createState() => _DopOptionsState();
}

class _DopOptionsState extends State<DopOptions> {

  TextEditingController myController = TextEditingController();

  ////////////////////////answer options
  //countPassanger:
  int countPassanger = 3;
  setCountPassanger(int value) {
    setState(() {
      countPassanger = value;
    });
  }
  //baggage:
  int baggage = 2;
  setBaggage(int value) {
    setState(() {
      baggage = value;
    });
  }
  //childPassanger:
  int childPassange = 2;
  setChildPassange(int value) {
    setState(() {
      childPassange = value;
    });
  }
  //animalRide:
  int animalRide = 2;
  setAnimalRide(int value) {
    setState(() {
      animalRide = value;
    });
  }
  //smoking:
  int smoking = 2;
  setSmoking(int value) {
    setState(() {
      smoking = value;
    });
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
          Container(
      color: Colors.white,
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
      Align(
      alignment: Alignment.center,
      child: Text(
        "Дополнительные опции",
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
  child:   ListView(
  
          padding: EdgeInsets.symmetric(horizontal: 16),

          children: [
 
            Container(  
              padding: EdgeInsets.only(top: 24, bottom: 8),  
              child: Text(
  
                "Выберите",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
  
                pointAnswer(1, countPassanger, "1", setCountPassanger),
  
                SizedBox(width: 8),
  
                pointAnswer(2, countPassanger, "2", setCountPassanger),
  
                SizedBox(width: 8),
  
                pointAnswer(3, countPassanger, "3", setCountPassanger),
  
              ],
  
            ),
  
            Container(
  
              padding: EdgeInsets.only(top: 24, bottom: 8),
  
              child: Text(
  
                "Перевозка",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
  
                pointAnswer(1, baggage, "Yes", setBaggage),
  
                SizedBox(width: 8),
  
                pointAnswer(2, baggage, "No", setBaggage),
  
              ],
  
            ),
  
            Container(
  
              padding: EdgeInsets.only(top: 24, bottom: 8),
  
              child: Text(
  
                "Детское кресло",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
  
                pointAnswer(1, childPassange, "Yes", setChildPassange),
  
                SizedBox(width: 8),
  
                pointAnswer(2, childPassange, "No", setChildPassange),
  
              ],
  
            ),
  
            Container(
  
              padding: EdgeInsets.only(top: 24, bottom: 8),
  
              child: Text(
  
                "Животные",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
  
                pointAnswer(1, animalRide, "Yes", setAnimalRide),
  
                SizedBox(width: 8),
  
                pointAnswer(2, animalRide, "No", setAnimalRide),
  
              ],
  
            ),
  
            Container(  
              padding: EdgeInsets.only(top: 24, bottom: 8),  
              child: Text(  
                "Курение",  
                style: currentTextStyle,  
              ), 
            ),
            Row(
              children: [
                pointAnswer(1, smoking, "Yes", setSmoking),
                SizedBox(width: 8),
                pointAnswer(2, smoking, "No", setSmoking),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 24, bottom: 8),
              child: Text(
                "Коммент",
                style: currentTextStyle,
              ),
            ),
           Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color.fromRGBO(173, 179, 188, 1)),
            ),
            child:  TextField(
                style: currentTextStyle,
                controller: myController,
                decoration: InputDecoration(
                  
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
                  bool _baggage=baggage==1?true:false;
                  bool _childPassange=childPassange==1?true:false;
                  bool _animal=animalRide==1?true:false;
                  bool _smoking=smoking==1?true:false;
                  DopInfo dopInfo=DopInfo(countPassanger,_baggage,_childPassange,_animal,_smoking,myController.text);
                  Provider.of<CreateProvider>(context,listen: false).setDopInfo(dopInfo);
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context)=>Price(),
                      )
                      );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:Color.fromRGBO(64,123,255,1),
                    borderRadius: BorderRadius.circular(10)
                    
                  ),
                  child: Text(
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

Widget pointAnswer(
    dynamic index, dynamic currentIndex, String text, Function setIndex) {
  return GestureDetector(
    onTap: () {
      setIndex(index);
    },
    child: Container(
      width: 56,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
            color: index == currentIndex
                ? Color.fromRGBO(64, 123, 255, 1)
                : Color.fromRGBO(173, 179, 188, 1)),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: currentTextStyle.copyWith(
            color: Color.fromRGBO(85, 85, 85, 1),
          ),
        ),
      ),
    ),
  );
}

TextStyle currentTextStyle = TextStyle(
  fontFamily: "Poppins",
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Color.fromRGBO(51, 51, 51, 1),
);
