import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/chats/http_chats.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/menupages/create/card_order/card_full_order.dart';
import 'package:flutter_application_1/pages/menupages/provider/user_store.dart';
import 'package:flutter_application_1/socket/socket.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visibility_detector/visibility_detector.dart';
class MessagePage extends StatefulWidget{
  final int chatId;
  const MessagePage({required this.chatId, super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  TextEditingController _msgController= TextEditingController();
 List<AppMessage> appMessage=[]; 

 ScrollController _controller =ScrollController();
 FocusNode _focusNode=FocusNode();

  
void addMessage(AppMessage newAppMessage){
  appMessage.insert(0,newAppMessage);
  setState(() {
    
   
  });

}

void updateMessage(String uuid,int status,int messageId){
  int index = appMessage.indexWhere((item) => item.uuid ==uuid ); 
    AppMessage mess=appMessage[index];
    mess.status=status;
    mess.messageId=messageId;
  setState(() {
    
  });
}

  void fullRead(){
    print("FULLREAD");
   
    setState(() {
       appMessage.forEach((element) { 
      element.status=1;
    });
    });
  }

  void subscribe(){
    // setState(() {
      
    // });
  }
  ChatInfo? _chatInfo;

  Future getChatInfo()async{
     ChatInfo? chatInfo=await HttpChats().getChatInfo(widget.chatId);
     
      setState(() {
        _chatInfo=chatInfo;
      });
      getImage();
  }
  File? _imgFile;
Future getImage()async{
  File imgFile=await DefaultCacheManager().getSingleFile(_chatInfo!.chatMembers[0].photoUri);
 setState(() {
   _imgFile=imgFile;
 });
}
  initialize()async{
        getChatInfo();
        
        HttpChats().getChatMessage(widget.chatId, 0).then((value){
      setState(() {
        appMessage.addAll(value);
       // appSocket.addMessage(widget.chatId, value);
        
      });
     });
  }

  @override
  void initState() {
    appSocket.subscribe(subscribe);
    appSocket.addMessage=addMessage;
    appSocket.currentChatId=widget.chatId;
    appSocket.updateMessage=updateMessage;
    appSocket.fullRead=fullRead;
    
     initialize();
     
    super.initState();
  }  

  @override
  void dispose() {
    appSocket.unSubscribe();
    appSocket.currentChatId=-1;
    
   _msgController.dispose();
    super.dispose();
  }

  void sendMessage()async{
   await appSocket.sendMessage(
      _msgController.text,
      widget.chatId,

    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
  
  _controller.jumpTo(
    _controller.position.minScrollExtent, 
  );
});
    _msgController.text="";
  }


  @override
  Widget build(BuildContext context) {

    List<AppMessage> getCurrentMessage=appSocket.getCurrentMessage(widget.chatId);
    String formattedDate="";
    String formattedTime="";
    if(_chatInfo!=null){
      DateTime currDate=DateTime.fromMillisecondsSinceEpoch(_chatInfo!.createdAt*1000);
      formattedDate = DateFormat('d MMMM').format(currDate);
      List<String> dateComponents = formattedDate.split(' ');
      String day = dateComponents[0].padLeft(2, '0');
      String month = dateComponents[1];
      formattedDate = '$day $month';

      formattedTime = DateFormat('HH:mm').format(currDate);
      formattedTime = formattedTime.split(':').map((segment) => segment.padLeft(2, '0')).join(':');
    }
   
    return Scaffold(
      resizeToAvoidBottomInset:true,
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            toolbarOpacity: 0,
            elevation: 0,
            
        ),
        body: 
           GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
             child: Column(
              children: [
                Container(
                  height: 55,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(226,226,226, 1),
                        width: 1
                      )
                    )
                  ),
                  child: _chatInfo==null
                  ?CircularProgressIndicator()
                  :Row(
                      children:[
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 11),
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            } ,
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              child: SvgPicture.asset(
                              "assets/svg/back.svg"
                              ),
                            ),
                          ),
                        ),
                        _imgFile==null
                        ?Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: brandGrey
                                    ),
                                    height: 42,
                                    width: 42,
                                   
                                  ),
                                )
                                :ClipRRect(borderRadius: BorderRadius.circular(42), child: Image.file(_imgFile!,width: 42,height: 42,fit: BoxFit.cover,)),
                        
                       Padding(
                        padding: EdgeInsets.only(top: 9,bottom: 9,left: 12),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _chatInfo!.chatMembers[0].clientName,
                            style: TextStyle(
                              fontFamily: "SF",
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),
                            ),
                          Text(
                            _chatInfo!.chatMembers[0].status,
                            style: TextStyle(
                              fontFamily: "SF",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color.fromRGBO(58,121,215,1)
                            ),
                            )
                        ],
                                    ),
                      ),
                      ]
                      
                    )
                ),
                Container(
                  height: 65,
                  padding: EdgeInsets.only(left: 19.5),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(226,226,226, 1),
                        width: 1
                      )
                    )
                  ),
                  child: _chatInfo==null
                  ?CircularProgressIndicator()
                  :InkWell(
                    onTap: () {
                      Navigator.push(context,
                       MaterialPageRoute(builder: (context) => CardFullOrder(
                        side: (){},
                        startLocation: _chatInfo!.startLocation, 
                        endLocation: _chatInfo!.endLocation, 
                        orderId: _chatInfo!.orderId
                        ),
                        )
                        );
                    },
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              
                              width: MediaQuery.of(context).size.width-75,
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:8),
                                  child: Column(
                                    
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 17,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(horizontal: 4),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2),
                                            color: Color.fromRGBO(244, 244, 244, 1)
                                          ),
                                          child: Text(
                                            formattedDate,
                                            style: TextStyle(
                                              fontFamily: "SF",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: brandBlack
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8,),
                                         Container(
                                          height: 17,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(horizontal: 4),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2),
                                            color: Color.fromRGBO(244, 244, 244, 1)
                                          ),
                                          child: Text(
                                            formattedTime,
                                            style: TextStyle(
                                              fontFamily: "SF",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: brandBlack
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Text(
                                     _chatInfo!.startLocation[0].toUpperCase()+_chatInfo!.startLocation.substring(1),
                                     style: TextStyle(
                                        fontFamily: "SF",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: brandBlack
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                  ],
                                                          ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:19),
                                  child: Column(
                                    
                                  children: [
                                    
                                    Text(
                                      _chatInfo!.endLocation[0].toUpperCase()+_chatInfo!.endLocation.substring(1),
                                      style: TextStyle(
                                        fontFamily: "SF",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: brandBlack
                                      ),
                                    )
                                  ],
                                                          ),
                                ),
                              ],
                            ) 
                            ),
                            Row(
                              children: [
                               
                              Container(
                                    height: 7,
                                    width: 7,
                                    decoration: BoxDecoration(
                                      color: brandBlue,
                                      borderRadius: BorderRadius.circular(7)
                                    ),
                                  ),
                                  DashedLineWidget(windowWidth: MediaQuery.of(context).size.width-89),
                                   Container(
                                    height: 7,
                                    width: 7,
                                    decoration: BoxDecoration(
                                      color: brandBlue,
                                      borderRadius: BorderRadius.circular(7)
                                    ),
                                  )
                               
                              ],
                            )
                          ],
                        ),
                        
                        Expanded(
                          
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 12),
                            child: SvgPicture.asset(
                              "assets/svg/chevron-left.svg",
                              color: brandBlue,
                              ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: KeyboardListener(
                          focusNode: _focusNode,
                          onKeyEvent: (value) {
                            inspect(value);
                          },
                          child: ListView.builder(
                            reverse: true,
                            
                            controller: _controller,
                                    itemCount: appMessage.length,
                                    itemBuilder: (context, index) {
                                      return VisibilityDetector(
                                        key: Key(appMessage[index].uuid),
                                        onVisibilityChanged: (info) {
                                         
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
                                          child: Container(
                                            
                                            alignment:appMessage[index].clientId!=userStore.userInfo.clienId?Alignment.centerLeft:Alignment.centerRight,
                                            child: Stack(
                                              alignment:appMessage[index].clientId==userStore.userInfo.clienId? Alignment.bottomRight:Alignment.bottomLeft,
                                              children: [
                                                Container(
                                                  
                                                  margin:appMessage[index].clientId==userStore.userInfo.clienId? EdgeInsets.only(right: 5):EdgeInsets.only(left: 5),
                                                  decoration: BoxDecoration(
                                                      color: appMessage[index].clientId==userStore.userInfo.clienId?Color.fromRGBO(0, 122, 255, 1):Color.fromRGBO(229, 229, 234, 1),
                                                      borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  constraints: BoxConstraints(
                                                    minWidth: 100,
                                                    maxWidth: 234
                                                  ),
                                                  padding: EdgeInsets.only(left: 14,right: 30,top: 7, bottom: 7),
                                                    
                                                  child: Text(
                                                    appMessage[index].text,
                                                    style: TextStyle(
                                                      color: appMessage[index].clientId==userStore.userInfo.clienId?Colors.white:Colors.black,
                                                      fontFamily: "SF",
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 17,
                                                      letterSpacing: -0.41
                                                    ),
                                                  ),
                                                ),
                                                appMessage[index].clientId==userStore.userInfo.clienId?Image.asset("assets/image/tailBlue.png"):Image.asset("assets/image/tailGray.png"),
                                                appMessage[index].clientId==userStore.userInfo.clienId? Positioned(
                                                  bottom: 5,
                                                  right: 15,
                                                  child: Icon(appMessage[index].status==1?Icons.done_all: appMessage[index].status==-1?Icons.query_builder: Icons.done,size: 15,color: Colors.white,)//SvgPicture.asset("assets/svg/status_0.svg",color: Colors.white,width: 10,height: 10),
                                                ):SizedBox.shrink(),
                                                
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                        )
                       ),
                      Container(
                        height: 47.25,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 27.67,right: 15, bottom: 10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(248, 248, 248, 1),
                          border: Border(
                            top: BorderSide(
                              color: Color.fromRGBO(179, 179, 179, 1),
                              width: 1,
                              style: BorderStyle.solid
                            )
                          )
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                focusNode: _focusNode,
                                controller: _msgController,
                                textInputAction:TextInputAction.send,
                                onEditingComplete:(){
                                    sendMessage();
                                },
                               
                                style: TextStyle( 
                                  color: brandBlack,
                                  fontSize: 17
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type your message here..",
                                  hintStyle: TextStyle(
                                    color: brandGrey
                                  )
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                               sendMessage();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Send",
                                  style: TextStyle(
                                    color: brandBlue,
                                    fontFamily: "SF",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
              ),
           ),
        
      );
  }
}