import 'package:ezride/app_localization/app_localizations.dart';
import 'package:ezride/pages/mainapp/menupages/search/UI/calendare/calendare.dart';
import 'package:ezride/pages/mainapp/menupages/search/UI/card_coordinates.dart';
import 'package:ezride/pages/mainapp/menupages/search/result_search/result_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'UI/person_count/person_count.dart';

class DataCreate{
  String city;
  double longitude;
  double latitude;
  DataCreate(this.city,this.latitude,this.longitude);
}

class Search extends StatefulWidget{
  @override
  State<Search> createState() => _SearchState();
}



class _SearchState extends State<Search> {

  ///required data
  //from
  TextEditingController fromTextController= TextEditingController();
  //to
  TextEditingController toTextController= TextEditingController();

  DataCreate from =DataCreate("from",0,0);
  DataCreate to =DataCreate("to",0,0);
  DateTime date=DateTime.now();

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
  void updateDate(DateTime newdate){
    setState(() {
     date=newdate;
    });
  }

  void _search(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_)=>ResultSearch(from: from, to: to, date: date)
        )
        );
  }
  @override
  Widget build(BuildContext context) {
   return Column(
     children: [
       Container(
        height: 240,
        padding: EdgeInsets.only(top: 24,left: 15,right: 15),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 60),
              height: 240,
              
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(96,181,244,1),
                  borderRadius: BorderRadius.circular(11.2745)
                  
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Padding(
                      padding: EdgeInsets.only(top: 16,left: 16),
                      child: Text(
                        "EazyRide",
                        style:  TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600
                        ),
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8,left: 16),
                      child: Text(
                        AppLocalizations.of(context).farewell,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400
                        ),
                        ),
                    )
                  ],
                ),
              ),
            ),
            Image.asset("assets/image/carLitle.png")
          ],
        ),
       ),
       Padding(
        padding: EdgeInsets.only(top: 32,left: 15,right: 15),
        child: Column(
          children: [
           CardCoordinates(
            controller: fromTextController,
            icon: SvgPicture.asset(
                  "assets/svg/geoFrom.svg"
                  ),
            hint: "from",
            name: from.city,
            update:updateFrom,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CardCoordinates(
                update: updateTo,
                name: to.city,
              controller: toTextController,
              icon: SvgPicture.asset(
                    "assets/svg/geoTo.svg"
                    ),
              hint: "To",
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 47,
                    child: Calendare(date: date,updateDate: updateDate,)
                    ),
                  Expanded(
                    flex: 20,
                    child: PersonCount()
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:12),
              child: InkWell(
                onTap: (){
                  _search();
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
                    "Поиск",
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
       )
     ],
   );
  }
}