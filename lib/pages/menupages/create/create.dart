
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/http/orders/orders.dart';
import 'package:flutter_application_1/pages/menupages/create/UI/card_coordinates.dart';
import 'package:flutter_application_1/pages/menupages/create/auto/auto.dart';
import 'package:flutter_application_1/pages/menupages/create/card_order/card_order.dart';
import 'package:flutter_application_1/pages/menupages/create/create_title.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/provider/store.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/calendare/calendare.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/time_picker/time_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateTab extends StatefulWidget{
  const CreateTab({super.key});

  @override
  State<CreateTab> createState() => _CreateTab();
}

class _CreateTab extends State<CreateTab> {

  DateTime date=DateTime.now();

  void updateDate(DateTime newDate){
    setState(() {
      date=newDate;
    });
  }

  DateTime time=DateTime.now();
  void updateTime(DateTime newTime){
    setState(() {
      time=newTime;
    });
  }

      void updateFrom( DataCreate data){
        storeApp.setFrom(data);
      }
      void updateTo(DataCreate data){
        storeApp.setTo(data);
        
      }



void _showDialogPage(BuildContext context){
  DateTime validDate=DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
  storeApp.setDate(validDate);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const Auto()),
      
      );
}
  @override
  void initState() {
    HttpUserOrder().getUserOrders();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

      
    

    return  FutureBuilder<List<DriverOrder>>(
      future: HttpUserOrder().getUserOrders(),
      builder: (context, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator()
            );
        }
        if(snapshot.hasError){
            return Center(
              child: Text("Ошибка"),
            );
        }
        List<DriverOrder>? driverOrder=  snapshot.data;
        print(driverOrder);
          if(driverOrder!.isEmpty){
            return  CreateTitle(back: false,);
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: driverOrder.length,
                  itemBuilder: (context, index) {
                    return CardOrder(driverOrder: driverOrder[index],);
                  },
                  ),
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
                  child: InkWell(
                  onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => 
                          Material(
                            child: Scaffold( 
                              appBar:AppBar(
                                systemOverlayStyle: SystemUiOverlayStyle.dark,
                                toolbarHeight: 0,
                                backgroundColor: Colors.white,
                                toolbarOpacity: 0,
                                elevation: 1,
                                
                            ), 
                              body: CreateTitle(back: true,),
                              )
                            ),
                          )
                        );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color:const Color.fromRGBO(64,123,255,1),
                      borderRadius: BorderRadius.circular(10)
                      
                    ),
                    child: const Text(
                      "Создать поездку",
                      style: TextStyle(
                        color: Color.fromRGBO(255,255,255,1),
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                              ),
                ),
            ],
          );
      },
      );
  }
}