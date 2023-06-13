import 'package:easy_debounce/easy_debounce.dart';
import 'package:ezride/helpers/color_constants.dart';
import 'package:ezride/helpers/debounce.dart';
import 'package:ezride/http/city/city_model.dart';
import 'package:ezride/http/city/http_city.dart';
import 'package:ezride/pages/mainapp/menupages/search/from/from.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class CardCoordinates extends StatefulWidget{
 final SvgPicture icon;
 final String hint;
  TextEditingController controller;
  Function update;
  String name;
  CardCoordinates({required this.name, required this.update, required this.controller, required this.icon,required this.hint, super.key});

  @override
  State<CardCoordinates> createState() => _CardCoordinatesState();
}

class _CardCoordinatesState extends State<CardCoordinates> {



void _showAnimation(BuildContext context) {
  ArgumentSetting params = ArgumentSetting(widget.icon,widget.hint,widget.controller);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchFrom(update: widget.update,),
      
      settings: RouteSettings(arguments:params), 
    ),
  );
}





  @override
  Widget build(BuildContext context) {
   return GestureDetector(
      onTapDown: (details) {
        Offset tapPosition = details.globalPosition;
        _showAnimation(context);
  },
     child: Container(
              height: 60,
              decoration: BoxDecoration(
                //color: Color.fromRGBO(247,247,253,1),
                color: categorySelected,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 9),
                    child: widget.icon
                  ),
                   Text(widget.name.isNotEmpty?widget.name:widget.hint)
                ],
              ),
             ),
   );
  }
}

