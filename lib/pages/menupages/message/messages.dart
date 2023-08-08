
import 'package:flutter/material.dart';
import 'package:flutter_application_1/http/chats/http_chats.dart';
import 'package:flutter_application_1/pages/menupages/message/empty_state_message.dart';
import 'package:flutter_application_1/pages/menupages/message/mess/mess.dart';

class Messages extends StatefulWidget{
  Messages({super.key});

  final wsUrl = Uri.parse('ws://localhost:1234');
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20,bottom: 14 ),
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
             child: FutureBuilder<List<UserChats>>(
              future: HttpChats().getUserChats(),
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.hasError){
                  return Center(child: Text("ошибка"));
                
                }
                List<UserChats>? httpChats=snapshot.data;
                if(httpChats!.isEmpty){
                    return MessagesEmptyState();
                }
                return ListView.builder(
              itemCount: httpChats!.length,
              itemBuilder: (context,index){
                return Mess(
                    chat:httpChats![index]
                );
              },
              );
              },
              )
           )
          ],
      ),
    );
  }
}

 