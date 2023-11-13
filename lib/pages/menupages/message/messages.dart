
import 'package:flutter/material.dart';
import 'package:flutter_application_1/http/chats/http_chats.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/menupages/emptyState/empty_state.dart';
import 'package:flutter_application_1/pages/menupages/message/empty_state_message.dart';
import 'package:flutter_application_1/pages/menupages/message/mess/mess.dart';
import 'package:flutter_application_1/pages/menupages/message/message_page.dart';
import 'package:flutter_application_1/pages/menupages/provider/user_store.dart';

class Messages extends StatefulWidget{
  Messages({super.key});

  final wsUrl = Uri.parse('ws://localhost:1234');
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  List<UserChats> userChats=[];
  
  updateText(String text,int chatId ){
      
       int index= userChats.indexWhere((element) => element.chatId==chatId);
       
       if(index>=0){
          String newText=text;
          if(text.length>15){
              newText=newText.substring(0,15)+"...";
          }
          userChats[index].message=newText;
       }
        
       setState(() {
      });
  }

  updateCounter(int chatId){
    appSocket.resetCounterMessage(chatId);
    appSocket.updateCountMessage();
     
     setState(() {
       int index= userChats.indexWhere((element) => element.chatId==chatId);
       if(index>=0){
         
          userChats[index].unreadMsgs=0;
       }
     });
  }
 
    getUserChats()async{
      print("getUsersChats");
     List<UserChats> _userChats=await HttpChats().getUserChats();
     _userChats.forEach((element) { 
        appSocket.counterMessage[element.chatId]=element.unreadMsgs;
     });
     
     setState(() {
       userChats=_userChats;
     });
    }

  @override
  void initState() {
    if(userStore.userInfo.auth){
          appSocket.updateTextInChats=updateText;
           getUserChats();
    }
  
    
  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    bool auth = userStore.userInfo.auth;

    return auth? Padding(
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
             child: userChats.isEmpty
             ?MessagesEmptyState()
             :ListView.builder(
              itemCount: userChats.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: () {
                    updateCounter(userChats[index].chatId);
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MessagePage(chatId: userChats[index].chatId),)
                        );
                  },
                  child: Mess(
                      chat:userChats[index]
                  ),
                );
              },
              )
           )
          ],
      ),
    )
    :EmptyStateAllPAge();
  }
}

 