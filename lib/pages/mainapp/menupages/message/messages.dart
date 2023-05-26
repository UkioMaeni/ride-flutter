import 'package:ezride/pages/mainapp/menupages/message/mess/mess.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
class Messages extends StatefulWidget{
  Messages({super.key});

  final wsUrl = Uri.parse('ws://localhost:1234');
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {



List<Map<dynamic, dynamic>> mess =[
  { "img":'https://i.pinimg.com/originals/8a/de/fe/8adefe5af862b4f9cec286c6ee4722cb.jpg',}
];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 14 ),
              child: Text(
                "Messages",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 24
                ),
                ),
            ),
           Expanded(
             child: ListView.builder(
              itemCount: mess.length,
              itemBuilder: (context,index){
                return Mess(child: mess[index],);
              },
              )
           )
          ],
      ),
    );
  }
}