
import 'package:flutter/material.dart';
import 'package:flutter_application_1/menupages/create/auto/auto.dart';
import 'package:flutter_application_1/menupages/search/UI/card_coordinates.dart';
import 'package:flutter_application_1/pages/mainapp/create/provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
class Create extends StatefulWidget{
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {


  DataCreate from =DataCreate("from",0,0);
  DataCreate to =DataCreate("to",0,0);

void _showDialogPage(BuildContext context){
  Provider.of<CreateProvider>(context,listen: false).setFrom(from);
  Provider.of<CreateProvider>(context,listen: false).setTo(to);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Auto()),
      
      );
}

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
  @override
  Widget build(BuildContext context) {
    return 
      Padding(
        padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
        child: Column(
          children: [
            Text(
              "Создать обьявление",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(51,51,51,1)
              ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 40,bottom: 12),
              child: CardCoordinates(
                controller: TextEditingController(),
                hint: "from",
                name: from.city,
                icon: SvgPicture.asset(
                      "assets/svg/geoFrom.svg"
                      ),
                update: updateFrom,
              ),
            ),
            CardCoordinates(
              controller: TextEditingController(),
              hint: "to",
              name: to.city,
              icon: SvgPicture.asset(
                    "assets/svg/geoTo.svg"
                    ),
              update: updateTo,
            ),
           //Text("323 ${Provider.of<CreateProvider>(context).price}"),
              
            Padding(
                padding: const EdgeInsets.only(top:12),
                child: InkWell(
                  onTap: (){
                    _showDialogPage(context);
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
                      "Продолжить",
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
      );
  }
}