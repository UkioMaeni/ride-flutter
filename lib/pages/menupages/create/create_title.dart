
import 'package:flutter/material.dart';
import 'package:flutter_application_1/http/orders/orders.dart';
import 'package:flutter_application_1/pages/menupages/create/UI/card_coordinates.dart';
import 'package:flutter_application_1/pages/menupages/create/auto/auto.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/provider/store.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/calendare/calendare.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/time_picker/time_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateTitle extends StatefulWidget{
  final bool back;
  const CreateTitle({required this.back, super.key});

  @override
  State<CreateTitle> createState() => _CreateTitle();
}

class _CreateTitle extends State<CreateTitle> {

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

      
    

    return  Padding(
          padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: widget.back? InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                              "assets/svg/back.svg",
                              height: 12,
                              width: 6,
                                  ),
                            ):SizedBox.shrink(),
                          ),
                          const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Создать поездку",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40,bottom: 12),
                child: Observer(
                  builder: (context) {
                    return CardCoordinates(
                    hint: "from",
                    name: storeApp.from.city,
                    icon: SvgPicture.asset(
                          "assets/svg/geoFrom.svg"
                          ),
                    update: updateFrom,
                  );
                  },
                  
                ),
              ),
              Observer(
                builder: (context) {
                  return CardCoordinates(
                  hint: "to",
                  name: storeApp.to.city,
                  icon: SvgPicture.asset(
                        "assets/svg/geoTo.svg"
                        ),
                  update: updateTo,
                );
                },
                
              ),
             //Text("323 ${Provider.of<CreateProvider>(context).price}"),
              Padding(
                padding: const EdgeInsets.only(top:12,bottom: 12),
                child: Calendare(updateDate: updateDate, date: date),
              ),
              TimePicker(time: time,updateTime: updateTime, ),
              Padding(
                  padding: const EdgeInsets.only(top:12),
                  child: InkWell(
                    onTap: (){
                      _showDialogPage(context);
                    },
                    child: Observer(
                      builder: (context) {
                        return Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: storeApp.from.city!="from"&&storeApp.to.city!="to"?const Color.fromRGBO(64,123,255,1):const Color.fromRGBO(177,177,177,0.5),
                          borderRadius: BorderRadius.circular(10)
                          
                        ),
                        child: Text(
                          "Продолжить",
                          style: TextStyle(
                            color: storeApp.from.city!="from"&&storeApp.to.city!="to"?const Color.fromRGBO(255,255,255,1):const Color.fromRGBO(255,255,255,0.5),
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      );
                      },
                       
                    ),
                  ),
                )
            ],
          ),
        );
  }
}