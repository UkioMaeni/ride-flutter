
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/calendare/modal_calendare.dart';
import 'package:flutter_application_1/pages/menupages/search/UI/time_picker/modal_time_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';


class TimePicker extends StatefulWidget{
  final DateTime time;
  final Function updateTime;
  const TimePicker({required this.time,required this.updateTime, super.key});
  @override
  State<TimePicker> createState() => _TimePicker();
}

class _TimePicker extends State<TimePicker> {

    DateTime now = DateTime.now();
   late String time = DateFormat('HH:mm').format(now);

  void _showDialogPage(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context){
        return TimePickerModal(update:widget.updateTime);
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
            Text(DateFormat('HH:mm').format(widget.time))
          ],
        ),
      ),
    );
  }
}