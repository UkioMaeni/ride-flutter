import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/chats/http_chats.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/socket/socket.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';

class MessagePage extends StatefulWidget{
  final int chatId;
  final int userId;
  const MessagePage({required this.chatId,required this.userId, super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  TextEditingController _msgController= TextEditingController();


  
  void subscribe(){
    setState(() {
      
    });
  }

  @override
  void initState() {
    appSocket.subscribe(subscribe);
    HttpChats().getUserInfo(widget.userId)
      .then((value) {
        if(value!=null){

        }
      });
    super.initState();
  }  

  @override
  void dispose() {
    appSocket.unSubscribe();
   _msgController.dispose();
    super.dispose();
  }

  void sendMessage(){
    appSocket.sendMessage(
      _msgController.text,
      widget.chatId
    );
    _msgController.text="";
  }


  @override
  Widget build(BuildContext context) {

    List<AppMessage> getCurrentMessage=appSocket.getCurrentMessage(widget.chatId);


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
           Column(
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
                child: FutureBuilder<UserChatInfo?>(
          future: HttpChats().getUserInfo(widget.userId),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            if(snapshot.hasError){
              return CircularProgressIndicator();
            }
              UserChatInfo? userChatIfo=snapshot.data;
              if(userChatIfo!=null){
                return Row(
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(left: 24,right: 25),
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          } ,
                          child: SvgPicture.asset(
                          "assets/svg/back.svg"
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: DefaultCacheManager().getSingleFile(userChatIfo.photoUri),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                              return ClipRRect(borderRadius: BorderRadius.circular(42), child: Image.file(snapshot.data!,width: 42,height: 42,fit: BoxFit.cover,));
                            } else {
                              return Shimmer.fromColors(
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
                              ); // Или другой виджет загрузки
                            }
                        },
                        ),
                      
                     Padding(
                      padding: EdgeInsets.only(top: 9,bottom: 9,left: 12),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userChatIfo.nickname,
                          style: TextStyle(
                            fontFamily: "SF",
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),
                          ),
                        Text(
                          userChatIfo.state,
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
                    
                  );
              }
              return SizedBox.shrink();
          },
                
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                                itemCount: getCurrentMessage.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 20,left: 15,right: 15),
                                    child: Container(
                                      alignment:widget.userId==151?Alignment.centerLeft:Alignment.centerRight,
                                      child: Stack(
                                        alignment:widget.userId!=151? Alignment.bottomRight:Alignment.bottomLeft,
                                        children: [
                                          Container(
                                            margin:widget.userId!=151? EdgeInsets.only(right: 5):EdgeInsets.only(left: 5),
                                            decoration: BoxDecoration(
                                                color: widget.userId!=151?Color.fromRGBO(0, 122, 255, 1):Color.fromRGBO(229, 229, 234, 1),
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 234
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 14,vertical: 7),
                                              
                                            child: Text(
                                              getCurrentMessage[index].text+"///"+getCurrentMessage[index].status.toString(),
                                              style: TextStyle(
                                                color: widget.userId!=151?Colors.white:Colors.black,
                                                fontFamily: "SF",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                                letterSpacing: -0.41
                                              ),
                                            ),
                                          ),
                                          widget.userId!=151?Image.asset("assets/image/tailBlue.png"):Image.asset("assets/image/tailGray.png")
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                     ),
                    Container(
                      height: 88,
                      alignment: Alignment.topCenter,
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
                        children: [
                          Expanded(
                            child: TextField(
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
        
      );
  }
}