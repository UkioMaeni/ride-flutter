import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/chats/http_chats.dart';
import 'package:flutter_application_1/pages/menupages/message/mess/mess.dart';
import 'package:flutter_application_1/pages/menupages/message/message_page.dart';

class OrderPage extends StatefulWidget{
  final int clientId;
  final int orderId;
  const OrderPage({required this.clientId,required this.orderId, super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  void getChatId()async{
   int chatId=await HttpChats().getChatId(widget.orderId, widget.clientId);
    if(chatId!=-1){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MessagePage(
          chatId: chatId,
        ),)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            getChatId();
          },
          child: Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            color: brandBlue,
            child: Text("Contact the driver"),
          ),
        ),
      ),
    );
  }
}