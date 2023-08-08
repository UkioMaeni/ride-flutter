import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/http/chats/http_chats.dart';
import 'package:flutter_application_1/pages/menupages/message/message_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:string_to_color/string_to_color.dart';
class Mess extends StatefulWidget{
 final UserChats chat;
 const Mess({super.key, required this.chat});

  @override
  State<Mess> createState() => _MessState();
}

class _MessState extends State<Mess> {
  @override
  Widget build(BuildContext context) {


  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(widget.chat.createdAt * 1000);
  String formattedTime = DateFormat('HH:mm').format(dateTime);
    return InkWell(
      onTapDown: (details) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessagePage(chatId: widget.chat.chatId,userId: widget.chat.clientId),)
          );
  },
      child: SizedBox(
        height: 61,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorUtils.stringToColor(widget.chat.clientName),
                    borderRadius: BorderRadius.circular(45)
                  ),
                  child: Text(
                    widget.chat.clientName.isNotEmpty?widget.chat.clientName[0]:"A",
                    style: TextStyle(
                      fontSize: 25,
                      
                    ),
                    ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1
                    )
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 12,top: 13.5,bottom: 13.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.chat.clientName}   ${widget.chat.start}->${widget.chat.end}",
                    style: TextStyle(
                      fontFamily: "SF",
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                    ),
                  Text(
                    widget.chat.message,
                    style: TextStyle(
                      fontFamily: "SF",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color.fromRGBO(0,0,0,0.45)
                    ),
                    )
                ],
              ),
            )
              ],
            ),
             Padding(
              padding: EdgeInsets.only(top:13.5),
              child: Column(
                children: [
                  Text(
                    formattedTime,
                    style: TextStyle(
                        fontFamily: "SF",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromRGBO(0,0,0,0.65)
                      ),
                    ),
            
                ],
              ),
            )
            
            
          ],
        )
        ),
    );
  }
}