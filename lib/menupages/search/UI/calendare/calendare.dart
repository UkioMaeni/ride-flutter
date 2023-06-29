
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/menupages/search/UI/calendare/modal_calendare.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Calendare extends StatefulWidget{
  DateTime date;
  Function updateDate;
  Calendare({required this.updateDate, required this.date, super.key});
  @override
  State<Calendare> createState() => _CalendareState();
}

class _CalendareState extends State<Calendare> {

  

  void _showDialogPage(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context){
        return CalendarModal(update:widget.updateDate);
      },
      );
      
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        _showDialogPage(context);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color:categorySelected,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 11),
              child: SvgPicture.asset(
                      "assets/svg/calendare.svg"
                      ),
            ),
            Text(date.day==DateTime.now().day?"Today":DateFormat("dd MMMM yyyy").format(widget.date))
          ],
        ),
      ),
    );
  }
}