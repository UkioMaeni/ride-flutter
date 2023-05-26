import 'package:ezride/pages/mainapp/menupages/search/UI/calendare.dart';
import 'package:ezride/pages/mainapp/menupages/search/UI/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'UI/person_count.dart';

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
                  children: const [
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
                        "Moccked text",
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
           TextInput(
            controller: fromTextController,
            icon: SvgPicture.asset(
                  "assets/svg/geoFrom.svg"
                  ),
            hint: "From",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: TextInput(
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
                    child: Calendare()
                    ),
                  Expanded(
                    flex: 20,
                    child: PersonCount()
                    )
                ],
              ),
            )
          ],
        ),
       )
     ],
   );
  }
}