import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/orders/orders.dart';
import 'package:flutter_application_1/pages/UI/barNavigation/barNavigation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CardFullOrder extends StatefulWidget{
  const CardFullOrder({required this.startLocation,required this.endLocation,required this.orderId, super.key});

  final String endLocation;
  final int orderId;
  final String startLocation;

  @override
  State<CardFullOrder> createState() => _CardFullOrderState();
}

class _CardFullOrderState extends State<CardFullOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          BarNavigation(back: true, title: "${widget.startLocation[0].toUpperCase()+widget.startLocation.substring(1)} -> ${widget.endLocation[0].toUpperCase()+widget.endLocation.substring(1)}"),
          FutureBuilder<UserOrderFullInformation?>(
              future: HttpUserOrder().getOrderInfo(widget.orderId),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Center(
                    child: Text("error"),
                  );
                  
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                UserOrderFullInformation? fullUserOrder= snapshot.data;
                if(fullUserOrder==null){
                    return Center();
                }
                
                 final  _initialCameraPosition=CameraPosition(
                  target: LatLng(
                    fullUserOrder.location[0].latitude,
                    fullUserOrder.location[0].longitude
                    ),
                  zoom: 17  
                    );
                
                DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(fullUserOrder.departureTime * 1000);
                String formattedDate = DateFormat('d MMMM').format(dateTime);
                List<String> dateComponents = formattedDate.split(' ');
                String day = dateComponents[0].padLeft(2, '0');
                String month = dateComponents[1];
                formattedDate = '$day $month';
          
                String formattedTime = DateFormat('HH:mm').format(dateTime);
                formattedTime = formattedTime.split(':').map((segment) => segment.padLeft(2, '0')).join(':');
          
                return  SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(238, 238, 238, 1)
                        ),
                        
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${fullUserOrder.price}0 \$",
                                    style: TextStyle(
                                                    fontFamily: "SF",
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromRGBO(0, 0, 0, 0.87)
                                                  ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(244, 244, 244, 1)
                                                ),
                                                child: Text(
                                                  formattedDate,
                                                  style: TextStyle(
                                                    fontFamily: "SF",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: brandBlack
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 4,),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(244, 244, 244, 1)
                                                ),
                                                child: Text(
                                                  formattedTime,
                                                  style: TextStyle(
                                                    fontFamily: "SF",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: brandBlack
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            fullUserOrder.location[0].city,
                                            style: TextStyle(
                                                    fontFamily: "SF",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: brandBlack
                                                  ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            fullUserOrder.location[1].city,
                                            style: TextStyle(
                                                    fontFamily: "SF",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: brandBlack
                                                  ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Свободные места ${fullUserOrder.seatsInfo.free}/${fullUserOrder.seatsInfo.total}",
                                    style: TextStyle(
                                                    fontFamily: "SF",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: brandBlack
                                                  ),
                                  ),
                                  Row(
                                    children: [
                                      for (int i = 0; i < fullUserOrder.seatsInfo.reserved; i++) Padding(
                                            padding: const EdgeInsets.only(right: 5.7),
                                            child: SvgPicture.asset("assets/svg/passanger.svg"),
                                          ),
                            
                                       for (int i = 0; i < fullUserOrder.seatsInfo.free; i++) Padding(
                                              padding: const EdgeInsets.only(right: 5.7),
                                              child: SvgPicture.asset("assets/svg/passanger_empty.svg"),
                                            ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 7,
                                          height: 7,
                                          decoration: BoxDecoration(
                                            color: brandBlue,
                                            borderRadius: BorderRadius.circular(7)
                                          ),
                                      ),
                                      Expanded(
                                        child: DashedLineWidget(windowWidth: MediaQuery.of(context).size.width, )
                                        ),
                                        Container(
                                          width: 7,
                                          height: 7,
                                          decoration: BoxDecoration(
                                            color: brandBlue,
                                            borderRadius: BorderRadius.circular(7)
                                          ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height:24 ,),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Данные о пассажирах",
                                    style: TextStyle(
                                                    fontFamily: "SF",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: brandBlack
                                                  ),
                                  ),
                                  fullUserOrder.travelers.length==0
                                  ?
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top:12,bottom: 12),
                                    height: 82,
                                    child: Column(
                                      children: [
                                        Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: brandGrey
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Text(
                                        "У вас пока нет попутчиков для\nсовместной поездки",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.6),
                                          fontFamily: "SF",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14
                                        ),
                                      )
                                      ],
                                    ),
                                  )
                                  : Row(
                                    children: [
                                        for (int i = 0; i < fullUserOrder.travelers.length; i++) Column( children: [
                                          Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: brandGrey
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            fullUserOrder.travelers[i].nickname
                                          )
                                        ],
                                      )
                                        ],)
                                      
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 24,),
                            Container(
                            
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Точка сбора на карте",
                                    style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.87),
                                          fontFamily: "SF",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16
                                        ),
                                  ),
                                  Container(
                                    
                                    height: 140,
                                    child: Stack(
                                      children: [
                                        GoogleMap(
                                          initialCameraPosition: _initialCameraPosition,
                                          scrollGesturesEnabled: false,
                                          myLocationButtonEnabled:false
                                          ),
                                          Center(
                                            child: SvgPicture.asset("assets/svg/geo.svg"),
                                          )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      fullUserOrder.location[0].location,
                                      style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.87),
                                            fontFamily: "SF",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                          ),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                            SizedBox(height: 24,),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Детали поездки",
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.87),
                                            fontFamily: "SF",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16
                                          ),
                                        ),
                                        
                                        Container(
                                          height: 68,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            border:Border(
                                              bottom: BorderSide(
                                                color: Color.fromRGBO(245, 245, 245, 1),
                                                width: 1,
                                                style: BorderStyle.solid
                                              )
                                            )
                                          ),
                                          child: Column(
                                            children: [
                                               Text(
                                                "Точка сбора",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14
                                                ),
                                              ),
                                              SizedBox(height: 4,),
                                              Text(
                                                fullUserOrder.location[0].location,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 68,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            border:Border(
                                              bottom: BorderSide(
                                                color: Color.fromRGBO(245, 245, 245, 1),
                                                width: 1,
                                                style: BorderStyle.solid
                                              )
                                            )
                                          ),
                                          child: Column(
                                            children: [
                                               Text(
                                                "Колличество мест",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14
                                                ),
                                              ),
                                              SizedBox(height: 4,),
                                              Text(
                                                fullUserOrder.seatsInfo.total.toString(),
                                                style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 68,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            border:Border(
                                              bottom: BorderSide(
                                                color: Color.fromRGBO(245, 245, 245, 1),
                                                width: 1,
                                                style: BorderStyle.solid
                                              )
                                            )
                                          ),
                                          child: Column(
                                            children: [
                                               Text(
                                                "Точка сбора",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14
                                                ),
                                              ),
                                              SizedBox(height: 4,),
                                              Text(
                                                fullUserOrder.location[0].location,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      
                    
                  ),
                );
              },
              
          )
        ],
      ),
    );
  }
}


class DashedLineWidget extends StatelessWidget {
  const DashedLineWidget({super.key, required this.windowWidth});

  final double windowWidth;

  @override
  Widget build(BuildContext context) {
    int count=windowWidth ~/20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            for (int i = 0; i < count; i++) Container(
                width:15,
                height: 1.5,
                decoration: BoxDecoration(
    
                  color: brandBlue,
                  borderRadius: BorderRadius.circular(10)
                ),
            )
        ],
      ),
    );
  }
}

