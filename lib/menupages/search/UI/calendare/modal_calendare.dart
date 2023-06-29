import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarModal extends StatefulWidget {
  Function update;
  CalendarModal({required this.update, super.key});

  @override
  _CalendarModalState createState() => _CalendarModalState();
}
DateTime date=DateTime.now();
class _CalendarModalState extends State<CalendarModal> {


  @override
  Widget build(BuildContext context) {
    return  Column(
        
        children: [
          InkWell(
            onTap: (){
              
              Navigator.pop(context);
            },
            child: Container(
              height: 100,
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                       TableCalendar(
                        
                         firstDay: DateTime.now(),
                          lastDay: DateTime(2024),
                          focusedDay: date,
                           headerStyle: HeaderStyle(
                              formatButtonVisible: false, // Скрыть кнопку выбора формата
                              titleCentered: true, // Выравнивание заголовка по центру
                              titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          onDaySelected:(selectedDay, focusedDay) {
                            setState(() {
                              widget.update(selectedDay);
                              Navigator.pop(context);
                              
                            });
                            print(date);
                            print("s $selectedDay");
                            print(focusedDay);
                          },
                    
                      
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
          
     
        );
  }
}