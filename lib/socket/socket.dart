import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';

class SocketMessage{
  String type;
  SocketMessage({
    required this.type
  });
}

class AppMessage{
  String text;
  int status;
  String uuid;
  int chatId;
  int date;
  AppMessage({
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

  Map<String,List<AppMessage>> mapMessages={};

  Future<void> insertMsgFromDB()async{
    List<AppMessage>appMess=await appDB.getMessages();
    Map<String, List<AppMessage>> chatMap = appMess.fold<Map<String, List<AppMessage>>>({}, (map, message) {
      if(map[message.chatId.toString()]==null){
        map[message.chatId.toString()]=[message];
      }else{
        map[message.chatId.toString()]!.insert(0, message);
      }
   
    return map;
  });
    mapMessages=chatMap;
  }

  Function _subcriber=(){};
  void subscribe(Function fn){
    _subcriber=fn;
  }
  void unSubscribe(){
    _subcriber=(){};
  }

  void editMessage(AppMessage newMsg,bool insert){
    
    if(mapMessages[newMsg.chatId.toString()]==null){
       mapMessages[newMsg.chatId.toString()]=[newMsg];
    }else{
      mapMessages[newMsg.chatId.toString()]!.insert(0, newMsg);
    }
    _subcriber();
    if(insert){
      insertToDB(newMsg);
    }
  }



  void editStatus(int chatId,String uuid,int status,){

   AppMessage? targetMessage = mapMessages[chatId.toString()]?.firstWhere((element) => element.uuid == uuid);
   if (targetMessage != null) {
    // Обновляем статус найденного объекта
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

    return mapMessages[chatId.toString()]??[]; 
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
            int chatId=statusMsg["chat_id"];
            String uuId=statusMsg["front_content_id"];

            editStatus(chatId,uuId,status);
          
        }
        if(message.type=="message"){
           Map<String,dynamic> mess=json.decode(event);
           String newUuid=uuid.v4();
           AppMessage newmsg=AppMessage(text: mess["content"], status: mess["status"], uuid: newUuid,chatId: mess["chat_id"], date:mess["sent_time"] );
           editMessage(
            newmsg,
            true
           );
           
           
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

  void sendMessage(String text,int chatId){
    String currUuid=uuid.v4();
    print(chatId);
    Map<String,dynamic> message={
      "front_content_id": currUuid,
      "type":"message",
      "content":text,
      "chat_id":chatId
    };
    print(message);
    AppMessage newMsg= AppMessage(text: text, status: -1, uuid: currUuid, chatId: chatId, date: -1);
    editMessage(newMsg,false);
    channel.sink.add(json.encode(message));
  }


}
