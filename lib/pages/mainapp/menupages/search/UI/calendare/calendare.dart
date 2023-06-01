import 'package:ezride/pages/mainapp/menupages/search/UI/calendare/modal_calendare.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Calendare extends StatefulWidget{
  const Calendare({super.key});
  @override
  State<Calendare> createState() => _CalendareState();
}

class _CalendareState extends State<Calendare> {

  DateTime date=DateTime.now();
  updateDate(DateTime newDate){
    setState(() {
      date=newDate;
    });
  }
  void _showDialogPage(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context){
        return CalendarModal(update:updateDate);
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
          color:Color.fromRGBO(65, 65, 156, 1),
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
            Text(date.day==DateTime.now().day?"Today":DateFormat("dd MMMM yyyy").format(date))
          ],
        ),
      ),
    );
  }
}