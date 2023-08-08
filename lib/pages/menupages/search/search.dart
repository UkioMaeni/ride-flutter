

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
    void setDate(DateTime newDate){
      print(newDate.toString());
      setState(() {
        date=newDate;
      });
    }

    int personCount=1;
    
        void setPersonCount(int newValue){
          
      setState(() {
        personCount=newValue;
      });
    }


  void updateFrom(DataCreate data){
    Provider.of<SearchProvider>(context,listen: false).setFrom(data);
      }
  void updateTo(DataCreate data){
    Provider.of<SearchProvider>(context,listen: false).setTo(data);
  }
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
  bool isFrom=true;
    bool isTo=true;
  
  @override
  Widget build(BuildContext context) {

    DataCreate from =Provider.of<SearchProvider>(context).from;
    DataCreate to =Provider.of<SearchProvider>(context).to;
    if(from.city.isNotEmpty){
      setState(() {
        isFrom=true;
      });
    }
    if(to.city.isNotEmpty){
      setState(() {
        isTo=true;
      });
    }
  void search(){
    if(from.city.isEmpty){
      print("f");
      setState(() {
        isFrom=false;
      });
    }
    if(to.city.isEmpty){
      print("t");
      setState(() {
        isTo=false;
      });
    }
    if(isFrom&&isTo){
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_)=>ResultSearch(from: from, to: to, date: date,count:personCount)
        )
        );
    }
    
  }
  print(isFrom);
   return Column(
     children: [
       Padding(
         padding: const EdgeInsets.only(top:24,left: 15,right: 15),
         child: Image.asset("assets/image/search.png"),
       ),
       Padding(
        padding: const EdgeInsets.only(top: 32,left: 15,right: 15),
        child: Column(
          children: [
           CardCoordinates(
            valid:isFrom,
            icon: SvgPicture.asset(
                  "assets/svg/geoFrom.svg"
                  ),
            hint: "From",
            name: from.city,
            update:updateFrom,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CardCoordinates(
                valid:isTo,
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
                  child: Calendare(date: date,updateDate: setDate,)
                  ),
                 Expanded(
                  flex: 20,
                  child: PersonCount(count:personCount,update:setPersonCount)
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
                    color:const Color.fromRGBO(64,123,255,1),
                    borderRadius: BorderRadius.circular(10)
                    
                  ),
                  child: Text(
                    "Поиск",
                    style: TextStyle(
                      color: Colors.white,
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