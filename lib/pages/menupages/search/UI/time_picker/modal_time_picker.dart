import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class TimePickerModal extends StatefulWidget {
  final Function update;
  const TimePickerModal({required this.update, super.key});

  @override
  State<TimePickerModal> createState() => _TimePickerModal();
}
DateTime date=DateTime.now();
class _TimePickerModal extends State<TimePickerModal> {


  @override
  Widget build(BuildContext context) {
    return  Column(
        
        children: [
          InkWell(
            onTap: (){
              
              Navigator.pop(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height*0.6,
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                       TimePickerSpinner(
                        is24HourMode: true,
                          normalTextStyle: TextStyle(fontSize: 24),
                          highlightedTextStyle: TextStyle(fontSize: 30, color: Colors.blue),
                          spacing: 30,
                          itemHeight: 80,
                          onTimeChange: (time) {
                            widget.update(time);
                          },
                       )
                  ],
                ),
              ),
            ),
          ),
        ],
          
     
        );
  }
}