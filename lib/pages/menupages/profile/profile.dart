
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/menupages/profile/Paragraf/paragraf.dart';
import 'package:flutter_application_1/pages/menupages/profile/Punkt/punkt.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';
import 'package:share/share.dart';


 //Поделится:
   void share(){
    Share.share('НАше крутое приложение');
   }

//required data
List list=[
  const Paragraf(paragraf: "Настройки аккаунта"),
  Punkt(punkt: "личн дан",onTap: (context){},),
  Punkt(punkt: "уведомл",onTap: (context){}),
  Punkt(punkt: "парол",onTap: (context){}),
  const Paragraf(paragraf: "Помощь"),
  Punkt(punkt: "FAQ",onTap: (context){}),
  Punkt(punkt: "связаться с нами",onTap: (context){}),
  const Paragraf(paragraf: "Дополнительно"),
  Punkt(punkt: "как стать лучше",onTap: (context){}),
  Punkt(punkt: "польз соглаш",onTap: (context){}),
  Punkt(punkt: "полит конфед",onTap: (context){}),
  Punkt(punkt: "усл использ",onTap: (context){}),
  const Punkt(punkt: "пригл друзей",onTap: share),
  Punkt(punkt: "оцен прилож",onTap: (context){}),
 Paragraf(paragraf: "Exit",onTap: (context){
   TokenStorage().clearSharedPreferences().then((_){
    Navigator.pushNamedAndRemoveUntil(context,"/reg",(route)=>false);
   });
 },)
  

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
          const Padding(
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