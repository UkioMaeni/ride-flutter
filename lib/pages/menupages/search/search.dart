

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/calendare/calendare.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/card_coordinates.dart';
import 'package:flutter_application_1/pages/menupages/search/result_search/result_search.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'UI/person_count/person_count.dart';


class Search extends StatefulWidget{
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}



class _SearchState extends State<Search> {


  

  DateTime date=DateTime.now();

//  void updateFrom(DataCreate data){
//     setState(() {
//       from=DataCreate(data.city, data.latitude, data.longitude);
//     });
//   }
//   void updateTo(DataCreate data){
//     setState(() {
//       to=DataCreate(data.city, data.latitude, data.longitude);
//     });
//   }
//   void updateDate(DateTime newdate){
//     setState(() {
//      date=newdate;
//     });
//   }

  
  @override
  Widget build(BuildContext context) {

    DataCreate from =Provider.of<SearchProvider>(context).from;
    DataCreate to =Provider.of<SearchProvider>(context).to;
    
  void search(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_)=>ResultSearch(from: from, to: to, date: date)
        )
        );
  }

  void updateFrom(DataCreate data){
    Provider.of<SearchProvider>(context,listen: false).setFrom(data);
      }
  void updateTo(DataCreate data){
    Provider.of<SearchProvider>(context,listen: false).setTo(data);
  }

   return Column(
     children: [
       Container(
        height: 240,
        padding: const EdgeInsets.only(top: 24,left: 15,right: 15),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 60),
              height: 240,
              
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(96,181,244,1),
                  borderRadius: BorderRadius.circular(11.2745)
                  
                ),
                child: const Column(
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
                        "",
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
        padding: const EdgeInsets.only(top: 32,left: 15,right: 15),
        child: Column(
          children: [
           CardCoordinates(
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
              icon: SvgPicture.asset(
                    "assets/svg/geoTo.svg"
                    ),
              hint: "To",
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 47,
                  child: Calendare(date: date,updateDate: (){},)
                  ),
                const Expanded(
                  flex: 20,
                  child: PersonCount()
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:12),
              child: InkWell(
                onTap: (){
                  search();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:from.city!="from"&&to.city!="to"?const Color.fromRGBO(64,123,255,1):const Color.fromRGBO(177,177,177,0.5),
                    borderRadius: BorderRadius.circular(10)
                    
                  ),
                  child: Text(
                    "Поиск",
                    style: TextStyle(
                      color: from.city!="from"&&to.city!="to"?const Color.fromRGBO(255,255,255,1):const Color.fromRGBO(255,255,255,0.5),
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