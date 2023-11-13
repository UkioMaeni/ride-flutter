import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';
import 'package:flutter_application_1/pages/menupages/message/mess/mess.dart';
import 'package:flutter_application_1/pages/menupages/provider/user_store.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';

class SocketMessage{
  String type;
  SocketMessage({
    required this.type
  });
}

class AppMessage{
  int clientId;
  String text;
  int status;
  String uuid;
  int messageId;
  int chatId;
  int date;
  
  AppMessage({
    required this.clientId,
    required this.messageId,
    required this.text,
    required this.status,
    required this.uuid,
    required this.chatId,
    required this.date
  });

  toMap(){
    return {
      "uuid":uuid,
      "text":text,
      "status":status,
      "chatId":chatId,
      "date":date
    };
  }
}




class SocketProvider with ChangeNotifier {
  WebSocketChannel channel;
  bool isAuth=false;
  Uuid uuid=const  Uuid();
  int page=1;
  int totalPage=1;
  int currentChatId=-1;

  Map<int,List<AppMessage>> mapMessages={};


  Map<int,int> counterMessage={};

  resetCounterMessage(int chatId){
    counterMessage[chatId]??=0;
    updateTextInChats("",0);
  }

  Function addMessage=(){};
  Function updateMessage=(){};
  Function fullRead=(){};
  // addMessage(int chatId,List<AppMessage> messages){
  //   if(mapMessages[chatId] != null){
  //       mapMessages[chatId]!.addAll(messages);
  //   }else{
  //     mapMessages[chatId]=messages;
  //   }
  //   _subcriber();
  // }


  // Future<void> insertMsgFromDB()async{
  //   List<AppMessage>appMess=await appDB.getMessages();
  //   Map<String, List<AppMessage>> chatMap = appMess.fold<Map<String, List<AppMessage>>>({}, (map, message) {
  //     if(map[message.chatId.toString()]==null){
  //       map[message.chatId.toString()]=[message];
  //     }else{
  //       map[message.chatId.toString()]!.insert(0, message);
  //     }
   
  //   return map;
  // });
  //   mapMessages={};//chatMap;
  // }

  Function _subcriber=(){};
  Function subcribeApp=(){};


  
  void subscribe(Function fn){
    _subcriber=fn;
  }
  void unSubscribe(){
    _subcriber=(){};
    fullRead=(){};
  }

  void editMessage(AppMessage newMsg,bool insert){
    
    if(mapMessages[newMsg.chatId]==null){
       mapMessages[newMsg.chatId]=[newMsg];
    }else{
      mapMessages[newMsg.chatId]!.insert(0, newMsg);
    }
    _subcriber();
    if(insert){
      insertToDB(newMsg);
    }
  }



  void editStatus(int chatId,String uuid,int status,){

   AppMessage? targetMessage = mapMessages[chatId.toString()]?.firstWhere((element) => element.uuid == uuid);
   if (targetMessage != null) {

    Future.delayed(Duration(milliseconds: 1000),() {


    targetMessage.status = status;

    _subcriber();
      insertToDB(targetMessage);
  });

  }
  
  }

  void insertToDB(AppMessage targetMessage){
      appDB.insertMessage(targetMessage);
  }


  List<AppMessage> getCurrentMessage(int chatId){

    return mapMessages[chatId]??[]; 
  }

  SocketProvider({required this.channel}) {
   channel.stream.listen((event) async{ 
      print("socket!");
      print(event);
        final parseMessage=json.decode(event);
        SocketMessage message=SocketMessage(type: parseMessage["type"]);
        if(message.type=="connection"){
            final token=await TokenStorage().getToken("access");
            final message=json.encode({
              "token":token,
              "type":"auth"
            });
            print(message);
              channel.sink.add(message);

        }
        if(message.type=="auth"){
          isAuth=true;
            // final message = json.encode({
            //   "client_id":122,
            //   "front_hash_id":1,
            //   "type":"message",
            //   "chat_id":4,
            //   "content":"211"
            // });
            // channel.sink.add(message);
            
              
        }
        if(message.type=="message-itself"){
          Map<String,dynamic> statusMsg=json.decode(event);
          int status=statusMsg["status"];
          int messageId=statusMsg["content_id"];
            int chatId=statusMsg["chat_id"];
            String uuId=statusMsg["front_content_id"];
            updateMessage(uuId,status,messageId);
           // editStatus(chatId,uuId,status);
          
        }
        if(message.type=="message"){
           Map<String,dynamic> mess=json.decode(event);
           String newUuid=uuid.v4();
           AppMessage newmsg=AppMessage(text: mess["content"], status: mess["status"], uuid: newUuid,chatId: mess["chat_id"], date:mess["sent_time"],messageId: mess["content_id"],clientId: -1 );
          
          if(newmsg.chatId==currentChatId){
              addMessage(newmsg);
          }else{
            if(counterMessage[newmsg.chatId]!=null){
              counterMessage[newmsg.chatId]=counterMessage[newmsg.chatId]!+1;
            }else{
              counterMessage[newmsg.chatId]=1;
            }
            subcribeApp();
            if(chatsSubscribe==false){

            }
            updateTextInChats(newmsg.text,newmsg.chatId);
            updateCountMessage();
          }
           
          //  editMessage(
          //   newmsg,
          //   true
          //  );
        }
        if(message.type=="full-read"){
          int chatId=json.decode(event)["chat_id"];
            if(currentChatId==chatId){
              fullRead();
            }

        }
   },
   onError: (error){
        print("e");
          if(error is SocketException){
            print(error);
          }
      },
      onDone: () {
        print("DISCONNECT");
      },
   );
  }



  Future<void> sendMessage(String text,int chatId)async{
    String currUuid=uuid.v4();
    print(chatId);
    Map<String,dynamic> message={
      "front_content_id": currUuid,
      "type":"message",
      "content":text,
      "chat_id":chatId
    };
    print(message);
    AppMessage newMsg= AppMessage(text: text, status: -1, uuid: currUuid, chatId: chatId, date: -1,messageId:-3,clientId: userStore.userInfo.clienId);
    //editMessage(newMsg,false);
    addMessage(newMsg);
     channel.sink.add(json.encode(message));
     Map<String,dynamic> read={
      "chat_id":chatId,
      "type":"message-read"
     };
     print(json.encode(read));
     channel.sink.add(json.encode(read));
  }


  Function updateTextInChats=(String msg,int chatId){};
  bool chatsSubscribe=false;
  Function updateCountMessage=(){};

}
