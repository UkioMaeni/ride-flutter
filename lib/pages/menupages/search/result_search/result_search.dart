
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
  Widget other=SizedBox.shrink();
  int currentIndex=0;
  late Future<List<int>> _futureSimilar;
  List<int> similarOrder=[];

  List<dynamic> listOrder=[];
  
  void getOtherOrder(int unixDate)async{
    
    List<DriverOrderFind> otherOrder = await  HttpUserOrder().findUserOrderByOtherCity(
                     widget.from.cityId!,
                     widget.to.cityId!,
                     widget.count,
                     unixDate
                    );
                    print(otherOrder.length);
                    if(otherOrder.length>0){
                      setState(() {
                        listOrder.add(Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text("Ride on other cities",textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 20,
                            fontFamily: "SF"
                          ),),
                        ));
                        listOrder.add(Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 31),
                          child: Image.asset("assets/image/otherCity1.png",),
                        ));
                        listOrder.addAll(otherOrder);
                       
                      });
                    }
  }

  void getOrder(int unixDate)async{
        List<DriverOrderFind> otherOrder = await  HttpUserOrder().findUserOrder(
                     widget.from.cityId!,
                     widget.to.cityId!,
                     widget.count,
                     unixDate
                    );
                    if(otherOrder.length>0){
                      setState(() {
                        listOrder.insert(0,otherOrder);
                       
                      });
                    }else{
                      setState(() {
                        listOrder.insert(0, Column(
                          children: [
                            Image.asset("assets/image/emptyOrder.png"),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Text(
                                    "Unfortunately, the travel companion\nwas not found at this date.\nPlease choose another date\nfrom those suggested above or try later.",
                                    textAlign: TextAlign.center,
                                ),
                            ),
                          ],
                        ));
                       
                      });
                    }
  }

  @override
  void initState() {
     
     final date1=widget.date.millisecondsSinceEpoch ~/1000;
     final date2=widget.date.timeZoneOffset.inHours*3600+date1;
    currentUnixDate=date1;
    similarOrder.add(currentUnixDate);
    getOrder(date1);
     getOtherOrder(date1);
    _futureSimilar=HttpUserOrder().findUserSimilarOrder(
                              widget.from.cityId!,
                                widget.to.cityId!,
                                widget.count,
                                currentUnixDate-12*60*60*24
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
            elevation: 0,
            
        ),
      body: Column(
        children: [
          BarNavigation(back: true, title: "${widget.from.city} - ${widget.to.city}"),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8,bottom: 10),
                        child: Text(
                          "Transportation on other days",
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
                                  child: Text("error")
                                );
                              }
                              List<int> similar=[widget.date.millisecondsSinceEpoch ~/1000];
                              similar.addAll(snapshot.data!);
                             
                              
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

                    child: ListView.builder(
                          itemCount: listOrder.length,
                          itemBuilder: (context, index) {
                            if(listOrder[index] is Column){
                              return listOrder[index];
                            }
                            if(listOrder[index] is Padding){
                              return listOrder[index];
                            }
                            if(listOrder[index] is Image){
                              return listOrder[index];
                            }
                            else{
                               return CardsearchOrderSearch(driverOrder: listOrder[index],seats:widget.count);
                            }
                           
                          },
                          
                     
                  )
                  )
                
                
        ],
      ),
    );
  }
}