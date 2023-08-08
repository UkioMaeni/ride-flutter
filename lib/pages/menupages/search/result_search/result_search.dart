
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/http/orders/orders.dart';
import 'package:flutter_application_1/pages/UI/barNavigation/barNavigation.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/search_card/search_card.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/search_card/search_card_search.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ResultSearch extends StatefulWidget{
 final int count;
 final DataCreate from;
 final DataCreate to;
 final DateTime date;

 const ResultSearch({required this.count, required this.from,required this.to,required this.date, super.key});

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {


  DateFormat dateFormat = DateFormat('d MMMM');
  late int currentUnixDate; 
 
  int currentIndex=0;
  late Future<List<int>> _futureSimilar;
  List<int> similarOrder=[];
  @override
  void initState() {
     
     final date1=widget.date.millisecondsSinceEpoch ~/1000;
     currentUnixDate=widget.date.timeZoneOffset.inHours*3600+date1;
   
    similarOrder.add(currentUnixDate);
    _futureSimilar=HttpUserOrder().findUserSimilarOrder(
                              widget.from.cityId!,
                                widget.to.cityId!,
                                widget.count,
                                currentUnixDate
                            );

    super.initState();
  }

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
          BarNavigation(back: true, title: "${widget.from.city} -> ${widget.to.city}"),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
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
                          child: FutureBuilder<List<int>>(
                            future: _futureSimilar,
                            builder: (context, snapshot) {
                              if(snapshot.connectionState==ConnectionState.waiting){
                                return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: 91,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100]!,
                                        borderRadius: BorderRadius.circular(32),
                                        border: Border.all(color: const Color.fromRGBO(64, 123, 255, 1)),
                                      ),
                                    ),
                                ),
                              );
                            }
                            );
                              }
                              if(snapshot.hasError){
                                return Center(
                                  child: Text("Ошибка")
                                );
                              }
                              List<int> similar=[widget.date.millisecondsSinceEpoch ~/1000];
                              similar.addAll(snapshot.data!);
                             
                              print(similar);
                              return ListView.builder(
                                itemCount: similar.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(32),
                                  onTap: () {
                                    if(currentIndex!=index){
                                      setState(() {
                                        currentUnixDate=similar[index];
                                        currentIndex=index;
                                    });
                                      }
                                   
                                    
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32),
                                      border: Border.all(
                                        color: index==0
                                        ?Colors.green
                                        :currentIndex==index? Color.fromRGBO(64,123,255,1)
                                        :Color.fromRGBO(173,179,188, 1)
                                        )
                                    ),
                                    width: 91,
                                    height: 32,
                                    child: Text(
                                      dateFormat.format( DateTime.fromMillisecondsSinceEpoch(similar[index]*1000)),
                                      style: const TextStyle(
                                        fontFamily: "SF",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(51, 51, 51, 1)
                                      ),
                                      ),
                                  ),
                                ),
                              );
                                },
                                );
                            },
                            )
                        ),
                
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<DriverOrderFind>>(
                    future: HttpUserOrder().findUserOrder(
                     widget.from.cityId!,
                     widget.to.cityId!,
                     widget.count,
                     currentUnixDate
                    ),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(), 
                        );
                      }
                      if(snapshot.hasError){
                        return Center(
                          child: Text("Ошибка"),
                        );
                      }
                      List<DriverOrderFind>? driverOrder=  snapshot.data;
                      
                      if( driverOrder!.isEmpty){
                        return Center(
                          child: Text("список пуст"),
                        );
                      }
                      return ListView.builder(
                        itemCount: driverOrder.length,
                        itemBuilder: (context, index) {
                          return CardsearchOrderSearch(driverOrder: driverOrder[index]);
                        },
                        );
                    },
                    ),
                )
        ],
      ),
    );
  }
}