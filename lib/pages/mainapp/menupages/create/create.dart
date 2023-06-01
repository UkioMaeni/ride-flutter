import 'package:ezride/pages/mainapp/menupages/search/UI/card_coordinates.dart';
import 'package:ezride/pages/mainapp/menupages/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Create extends StatefulWidget{
  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {

  DataCreate from =DataCreate("from",0,0);
  DataCreate to =DataCreate("to",0,0);

void updateFrom(DataCreate data){
    setState(() {
      from=DataCreate(data.city, data.latitude, data.longitude);
    });
  }
  void updateTo(DataCreate data){
    setState(() {
      to=DataCreate(data.city, data.latitude, data.longitude);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
      child: Column(
        children: [
          Text("Создать обьявление"),
          Padding(
            padding: const EdgeInsets.only(top: 40,bottom: 12),
            child: CardCoordinates(
              controller: TextEditingController(),
              hint: "from",
              name: from.city,
              icon: SvgPicture.asset(
                    "assets/svg/geoFrom.svg"
                    ),
              update: updateFrom,
            ),
          ),
          CardCoordinates(
            controller: TextEditingController(),
            hint: "to",
            name: to.city,
            icon: SvgPicture.asset(
                  "assets/svg/geoTo.svg"
                  ),
            update: updateTo,
          ),
          Padding(
              padding: const EdgeInsets.only(top:12),
              child: InkWell(
                onTap: (){
                  ///TODO 
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:from.city!="from"&&to.city!="to"?Color.fromRGBO(64,123,255,1):Color.fromRGBO(177,177,177,0.5),
                    borderRadius: BorderRadius.circular(10)
                    
                  ),
                  child: Text(
                    "Продолжить",
                    style: TextStyle(
                      color: from.city!="from"&&to.city!="to"?Color.fromRGBO(255,255,255,1):Color.fromRGBO(255,255,255,0.5),
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