import 'package:ezride/http/user/http_user.dart';
import 'package:ezride/pages/mainapp/menupages/create/create.dart';
import 'package:ezride/pages/mainapp/menupages/message/messages.dart';
import 'package:ezride/pages/mainapp/menupages/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MainApp extends StatefulWidget{
  WebSocketChannel channel;
  MainApp({required this.channel, super.key});
  
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  getUserInfo()async{
    await HttpUser().getUser();
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            toolbarOpacity: 0,
            elevation: 1,
            
        ),
        body: TabBarView(
          children: [
           Search(),
            Create(),
            Messages(),
            Center(
              child: Text("3"),
            )
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromRGBO(87,87,88,0.2),
                width: 1
              )
            )
          ),
          child: TabBar(
            labelColor: Color.fromRGBO(58,121,215,1),
            unselectedLabelColor: Color.fromRGBO(51,51,51,1),
            indicator: BoxDecoration(),
            labelStyle: TextStyle(
              color: Color.fromRGBO(51,51,51,1)
            ),
            tabs: [
                Tab(text: "Search",icon: Icon(Icons.search),),
                Tab(text: "Create",icon: Icon(Icons.control_point)),
                Tab(text: "Message",icon: Icon(Icons.forum_outlined)),
                Tab(text: "Profile",icon: Icon(Icons.account_circle_outlined))
            ],
          ),
        ),
      ),
    );
  }
}