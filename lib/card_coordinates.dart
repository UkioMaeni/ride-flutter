
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/menupages/search/from/from.dart';

class ArgumentSetting {
  String hint;
  TextEditingController controller;
  ArgumentSetting( this.hint, this.controller);
}


class CardCoordinates extends StatefulWidget{
 final String hint;
  TextEditingController controller;
  Function update;
  String name;
  CardCoordinates({required this.name, required this.update, required this.controller,required this.hint, super.key});

  @override
  State<CardCoordinates> createState() => _CardCoordinatesState();
}

class _CardCoordinatesState extends State<CardCoordinates> {



void _showAnimation(BuildContext context) {
  ArgumentSetting params = ArgumentSetting(widget.hint,widget.controller);
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
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 9),
                    child: Icon(Icons.abc)
                  ),
                   Text(widget.name.isNotEmpty?widget.name:widget.hint)
                ],
              ),
             ),
   );
  }
}

