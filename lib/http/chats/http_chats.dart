import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/http/instanse.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';


const baseUrl="http://31.184.254.86:9099/api/v1/client/chats";
const chatUrl="http://31.184.254.86:9099/api/v1/chat";

const fcmTokenUrl="http://31.184.254.86:9099/api/v1/push-token";
class UserChats{
  int orderId;
  int chatId;
  int clientId;
  String clientName;
  String start;
  String end;
  String message;
  int createdAt;
  UserChats({
    required this.orderId,
    required this.chatId,
    required this.clientId,
    required this.clientName,
    required this.start,
    required this.end,
    required this.message,
    required this.createdAt
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
      if(response.data==null){
        return [];
      }
      List<UserChats> userChats=[];
      List<dynamic> mockedList=response.data["data"];
      userChats= mockedList.map(
        (el) => UserChats(
          orderId: el["order_id"], 
          chatId: el["chat_id"], 
          clientId: el["client_id"], 
          clientName: el["client_name"], 
          start: el["start"], 
          end: el["end"], 
          message: el["message"], 
          createdAt: el["created_at"]
          )
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
}