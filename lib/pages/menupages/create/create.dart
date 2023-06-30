
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/menupages/create/UI/card_coordinates.dart';
import 'package:flutter_application_1/pages/menupages/create/auto/auto.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/provider/store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CreateTab extends StatefulWidget{
  const CreateTab({super.key});

  @override
  State<CreateTab> createState() => _CreateTab();
}

class _CreateTab extends State<CreateTab> {

  

      void updateFrom( DataCreate data){
        storeApp.setFrom(data);
      }
      void updateTo(DataCreate data){
        storeApp.setTo(data);
        
      }



void _showDialogPage(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const Auto()),
      
      );
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
              const Text(
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