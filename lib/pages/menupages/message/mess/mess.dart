import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/http/chats/http_chats.dart';
import 'package:flutter_application_1/main.dart';
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

int unread=appSocket.counterMessage[widget.chat.chatId]??0;
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(widget.chat.createdAt * 1000);
  String formattedTime = DateFormat('HH:mm').format(dateTime);
    return  SizedBox(
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
                    color: ColorUtils.stringToColor(widget.chat.chatMembers[0].clientName),
                    borderRadius: BorderRadius.circular(45)
                  ),
                  child: Text(
                    widget.chat.chatMembers[0].clientName.isNotEmpty?widget.chat.chatMembers[0].clientName[0]:"!",
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
                    "${widget.chat.chatMembers[0].clientName}   ${widget.chat.start} - ${widget.chat.end}",
                    style: TextStyle(
                      fontFamily: "SF",
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                    ),
                  Row(
                    children: [
                      Text(
                        widget.chat.message,
                        style: TextStyle(
                          fontFamily: "SF",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color.fromRGBO(0,0,0,0.45)
                        ),
                        ),
                        unread>0
                        ?Container(
                          margin: EdgeInsets.only(left: 15),
                        alignment: Alignment.center,
                        height: 17,
                        constraints: BoxConstraints(
                          minWidth: 14
                        ),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          unread.toString(),
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SF",
                            fontWeight: FontWeight.w600,
                            fontSize: 10
                          ),
                        ),
                      )
                        :SizedBox.shrink()
                    ],
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
        
    );
  }
}