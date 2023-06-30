
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/search_card/search_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ResultSearch extends StatefulWidget{

 final DataCreate from;
 final DataCreate to;
 final DateTime date;

 const ResultSearch({required this.from,required this.to,required this.date, super.key});

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {

  DateFormat dateFormat = DateFormat('d MMMM');  //фОРМАТ ДАТЫ



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            toolbarOpacity: 0,
            elevation: 1,
            
        ),
      body: Column(
        children: [
          Stack(
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
                "${widget.from.city} - ${widget.to.city}",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(51, 51, 51, 1),
                ),
                ),
              ),
            ],
          ),
                Padding(
                  padding: const EdgeInsets.only(left: 7,top: 20,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8,bottom: 10),
                        child: Text(
                          "Перевозка другие дни",
                          style: TextStyle(
                            fontFamily: "SF",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(51, 51, 51, 1)
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 32,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    border: Border.all(color: const Color.fromRGBO(64,123,255,1))
                                  ),
                                  width: 91,
                                  height: 32,
                                  child: Text(
                                    dateFormat.format(widget.date.add(Duration( days:index ))),
                                    style: const TextStyle(
                                      fontFamily: "SF",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(51, 51, 51, 1)
                                    ),
                                    ),
                                ),
                              );
                            }
                            ),
                        ),
                
                    ],
                  ),
                ),
                const SearchCard()
        ],
      ),
    );
  }
}