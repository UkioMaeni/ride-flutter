import 'package:easy_debounce/easy_debounce.dart';
import 'package:ezride/helpers/debounce.dart';
import 'package:ezride/http/city/city_model.dart';
import 'package:ezride/http/city/http_city.dart';
import 'package:ezride/pages/mainapp/menupages/search/from/from.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class TextInput extends StatefulWidget{
 final SvgPicture icon;
 final String hint;
  TextEditingController controller;
  TextInput({required this.controller, required this.icon,required this.hint, super.key});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {



void _showAnimation(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchFrom(),
      settings: RouteSettings(arguments:{ "icon":widget.icon,"hint":widget.hint,"controller":widget.controller}), 
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
                color: Color.fromRGBO(65, 65, 156, 1),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 9),
                    child: widget.icon
                  ),
                   Text("${widget.hint}")
                ],
              ),
             ),
   );
  }
}

