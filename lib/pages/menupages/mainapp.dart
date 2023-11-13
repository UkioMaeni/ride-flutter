
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/user/http_user.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/menupages/create/create.dart';
import 'package:flutter_application_1/pages/menupages/my_roads/my_roads.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_application_1/pages/menupages/message/messages.dart';
import 'package:flutter_application_1/pages/menupages/profile/profile.dart';
import 'package:flutter_application_1/pages/menupages/provider/user_store.dart';
import 'package:flutter_application_1/pages/menupages/search/search.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainApp extends StatefulWidget {
  const MainApp({ super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {





int _indexTab=0;

  getUserInfo() async {
    userStore.setUserInfo();
  }


 updateCountMessage(){
    setState(() {
      
    });
  }

  @override
  void initState() {
    if(userStore.userInfo.auth){
         getUserInfo();
      appSocket.updateCountMessage=updateCountMessage;
    }
     
      super.initState();
    }
   
     
 

  @override
  Widget build(BuildContext context) {
    int count=0;
    print(userStore.userInfo.auth);
    if(userStore.userInfo.auth){
        appSocket.counterMessage.forEach((key, value) {
        count+=value;
    });
    }
    
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          toolbarOpacity: 0,
          elevation: 0,
        ),
        body: TabBarView(
          clipBehavior: Clip.none,
          children: [
             const Search(),
             const MyRoads(),
            const CreateTab(),
            Messages(), 
            const Profile()
            ],
        ),
        
        bottomNavigationBar: Container(
          height: 72,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Colors.white, width: 1))),
          child:  TabBar(
            onTap: (value) {
              setState(() {
                _indexTab=value;
              });
            },
            padding: EdgeInsets.all(0),
            labelColor: Color.fromRGBO(58, 121, 215, 1),
            unselectedLabelColor: brandGrey,
            indicator: BoxDecoration(
              
            ),
            labelStyle: TextStyle(
              
              color: brandGrey,
              fontFamily: "Inter",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              
              ),
             labelPadding: EdgeInsets.only(bottom: 17,top: 0),
            indicatorPadding: EdgeInsets.zero,
            tabs: [

                 Tab(
                  icon:  SvgPicture.asset("assets/svg/searchTab.svg",color: _indexTab==0?brandBlue:brandGrey,),
                  iconMargin: EdgeInsets.only(bottom: 0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text("Search",)
                    ),
                  
                  
                ),
              Tab( 
                icon: SvgPicture.asset("assets/svg/roadsTab.svg",color: _indexTab==1?brandBlue:brandGrey),
                iconMargin: EdgeInsets.only(bottom: 0),
                child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text("My trips",)
                    ),
                ),
              Tab( 
                icon: SvgPicture.asset("assets/svg/createTab.svg",
                color: _indexTab==2?brandBlue:brandGrey),
                iconMargin: EdgeInsets.only(bottom: 0),
                child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text("Create",)
                    ),
                
                ),
              Tab( 
                icon: Stack(
                  children: [
                    
                    SvgPicture.asset(
                      "assets/svg/messageTab.svg",
                      color: _indexTab==3?brandBlue:brandGrey
                      ),
                      count>0? Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
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
                          count.toString(),
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SF",
                            fontWeight: FontWeight.w600,
                            fontSize: 10
                          ),
                        ),
                      )
                      ):SizedBox.shrink(),
                  ],
                ),
                iconMargin: EdgeInsets.only(bottom: 0),
                child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text("Messages",)
                    ),
                ),
              Tab( 
                icon: SvgPicture.asset("assets/svg/profileTab.svg",
                color: _indexTab==4?brandBlue:brandGrey),
                iconMargin: EdgeInsets.only(bottom: 0),
                child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    child: Text("Profile",)
                    ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
