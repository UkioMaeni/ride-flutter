
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/pages/menupages/search/from/from.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CardCoordinates extends StatefulWidget{
 final SvgPicture icon;
 final String hint;
 final Function update;
 final String name;
 const CardCoordinates({required this.name, required this.update, required this.icon,required this.hint, super.key});

  @override
  State<CardCoordinates> createState() => _CardCoordinatesState();
}

class _CardCoordinatesState extends State<CardCoordinates> {



void _showAnimation(BuildContext context) {
  ArgumentSetting params = ArgumentSetting(widget.icon,widget.hint);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchFrom(update: widget.update,),
      
      settings: RouteSettings(arguments:params), 
    ),
  );
}


@override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


   return GestureDetector(
      onTapDown: (details) {
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

