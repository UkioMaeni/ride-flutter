import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/socket/socket.dart';
import 'package:uuid/uuid.dart';


const baseUrl="http://31.184.254.86:9099/api/v1/client/chats";
const chatUrl="http://31.184.254.86:9099/api/v1/chat";
const baseAppUrl="http://31.184.254.86:9099/api/v1";
const fcmTokenUrl="http://31.184.254.86:9099/api/v1/push-token";
class UserChats{
  int orderId;
  int chatId;

  String start;
  String end;
  String message;
  int createdAt;
  int unreadMsgs;
  List<ChatMembers> chatMembers;
  UserChats({
    required this.unreadMsgs,
    required this.orderId,
    required this.chatId,
    required this.start,
    required this.end,
    required this.message,
    required this.createdAt,
    required this.chatMembers
  });
}

class UserChatInfo{
  String nickname;
  String photoUri;
  String state;
  UserChatInfo({
    required this.nickname,
    required this.photoUri,
    required this.state
  });
}

class HttpChats{

    Dio dio=Dio();
    HttpChats(){
      final authInterceptor=AuthInterceptor(dio);
      dio.interceptors.add(authInterceptor);
    }


    Future<List<UserChats>> getUserChats()async{
      String access= await TokenStorage().getToken("access");
      try {
        Response response=await dio.get(
        baseUrl,
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
      );
      print("response");
      print(response.data);
      if(response.data["data"]==null){
        return [];
      }
      List<UserChats> userChats=[];
      List<dynamic> mockedList=response.data["data"];
      userChats= mockedList.map(
        (el){
          List<dynamic> chatMembersUntyped=el["members"];
          List<ChatMembers> chatMembers=chatMembersUntyped.map((chtm)=>
            ChatMembers(clienId: chtm["client_id"], clientName: chtm["client_name"], photoUri: chtm["photo"], status: "online")
          ).toList();
         return UserChats(
          orderId: el["order_id"], 
          chatId: el["chat_id"], 
          unreadMsgs: el["unread_messages"],
          start: el["start"], 
          end: el["end"], 
          
          message: el["message"], 
          createdAt: el["created_at"],
          chatMembers: chatMembers
          );
        }
          ).toList();
      return userChats;
      } catch (e) {
        print(e);
        return [];
      }
    } 

    Future<int> getChatId(int orderId,int clientId)async{

        String access= await TokenStorage().getToken("access");
        
        try {
          Response response= await dio.post(
          chatUrl,
          data: {
            "order_id":orderId,
            "client_id":clientId
          },
          options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
          );  
          print(response);
          int chatId=response.data["data"]["chat_id"];
          return chatId;
        } catch (e) {
          print(e);
          return -1;

        }
    }

    Future<UserChatInfo?> getUserInfo(int userId)async{
      String access= await TokenStorage().getToken("access");
      try {
        Response response=await dio.get(
          "$chatUrl/client/$userId",
          options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
        );
        print(response);
        final res=response.data["data"];
        UserChatInfo userChatInfo=UserChatInfo(
          nickname: res["nickname"],
          photoUri: res["photo_url"],
          state: res["state"]
        );
        return userChatInfo;
      } catch (e) {
        print(e);
        return null;
      }
    }

    Future<int> setFcmToken(String token, )async{
      String access= await TokenStorage().getToken("access");
      String platform="";
        if(Platform.isAndroid){
          platform="android";
        }else if(Platform.isIOS){
          platform="ios";
        }
      try {
        Response response=await dio.put(
        fcmTokenUrl,
        data: {
          "token":token,
          "platform":platform
        },
        options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
        );
        print(response.data);
        return 0;
      } catch (e) {
        print(e);
        print("err fcm");
        return 1;
      }
    }

    Future<List<AppMessage>> getChatMessage(int chatId,int messageId)async{
      String access= await TokenStorage().getToken("access");
      try {
        Response response=await dio.get(
          "$baseAppUrl/chat/history/$chatId",
          queryParameters: {
            "message_id":messageId
          },
          options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
        );
        print(response.data);
        List<dynamic> listDinamic = response.data["data"]["messages"];
        ;
       List<AppMessage>listMessage= listDinamic.map((el)=>
              AppMessage(
                clientId: el["client_id"],
                messageId: el["message_id"],
                text: el["message"], 
                status: 1,
                uuid: Uuid().v4(), 
                chatId: response.data["data"]["chat_id"], 
                date: DateTime.now().second
                )).toList();
                return listMessage;
      } catch (e) {
        print("error messs");
        print(e);
        return [];
      }
    }


  Future<ChatInfo?> getChatInfo(int chatId)async{
      String access= await TokenStorage().getToken("access");
      try {
        Response response=await dio.get(
          "$chatUrl/$chatId",
          options: Options(
          headers: {
            "Authorization":"Bearer $access"
          }
        )
        );
        print(response.data);
        final t_chatInfo=response.data["data"];
          List<dynamic> t_chatMembers=t_chatInfo["chat_members"];
          List<ChatMembers> chatMembers= t_chatMembers.map((member)=>
            ChatMembers(
              clienId: member["client_id"], 
              clientName: member["client_name"], 
              photoUri: member["photo"], 
              status: member["status"]
              )
          ).toList();
       
          ChatInfo chatInfo=ChatInfo(
            chatId: t_chatInfo["chat_id"], 
            chatMembers: chatMembers, 
            createdAt: t_chatInfo["created_at"], 
            endLocation: t_chatInfo["end_location"], 
            orderId: t_chatInfo["order_id"], 
            startLocation: t_chatInfo["start_location"]
            );
        return chatInfo;
      } catch (e) {
        print(e);
        return null;
      }
    }

}

class ChatInfo{
  int chatId;
  int orderId;
  int createdAt;
  String startLocation;
  String endLocation;
  List<ChatMembers> chatMembers;
  ChatInfo({
    required this.chatId,
    required this.chatMembers,
    required this.createdAt,
    required this.endLocation,
    required this.orderId,
    required this.startLocation
  });
}

class ChatMembers{
  int clienId;
  String clientName;
  String photoUri;
  String status;
  ChatMembers({
    required this.clienId,
    required this.clientName,
    required this.photoUri,
    required this.status
  });
}