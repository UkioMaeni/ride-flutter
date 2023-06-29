

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/menupages/profile/Paragraf/Paragraf.dart';
import 'package:flutter_application_1/menupages/profile/Punkt/punkt.dart';
import 'package:share/share.dart';


 //Поделится:
   void share(){
    Share.share('НАше крутое приложение');
   }

//required data
List list=[
  Paragraf(paragraf: "Настройки аккаунта"),
  Punkt(punkt: "личн дан",OnTap: (){},),
  Punkt(punkt: "уведомл",OnTap: (){}),
  Punkt(punkt: "парол",OnTap: (){}),
  Paragraf(paragraf: "Помощь"),
  Punkt(punkt: "FAQ",OnTap: (){}),
  Punkt(punkt: "связаться с нами",OnTap: (){}),
  Paragraf(paragraf: "Дополнительно"),
  Punkt(punkt: "как стать лучше",OnTap: (){}),
  Punkt(punkt: "польз соглаш",OnTap: (){}),
  Punkt(punkt: "полит конфед",OnTap: (){}),
  Punkt(punkt: "усл использ",OnTap: (){}),
  Punkt(punkt: "пригл друзей",OnTap: share),
  Punkt(punkt: "оцен прилож",OnTap: (){}),
  Paragraf(paragraf: "Exit")
  

];
 
  //2nd:
  String  twoParagraf="Помощь";
  List<String> twoList=[
    "FAQ",
    "связаться с нами",
  ];
  ParagrafModel twoModel=ParagrafModel(twoParagraf, twoList);

  //3rd:
  String  threeParagraf="Дополнительно";
  List<String> threeList=[
    "как стать лучше",
    "польз соглаш",
    "полит конфед",
    "усл использ",
    "пригл друзей",
    "оцен прилож",
  ];
  ParagrafModel threeModel=ParagrafModel(threeParagraf, threeList);

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  


  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Профиль",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 26,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
         Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder:(context, index) {
              return list[index];
            },
            ),
         ),
          
        
        ],
      );
  }
}