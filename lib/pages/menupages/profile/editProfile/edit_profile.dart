import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/user/http_user.dart';
import 'package:flutter_application_1/pages/UI/barNavigation/barNavigation.dart';
import 'package:flutter_application_1/pages/menupages/provider/user_store.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  FocusNode _focusNode=FocusNode();
  TextEditingController _controller=TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    

    _focusNode.requestFocus();
  }
bool block=false;
void checkvalid()async{
  if(!block){
    block=true;
   int status=await HttpUser().editUser(_controller.text);
    block=false;
   if(status==0){
   await userStore.setUserInfo();
      Navigator.pop(context);
   }
    _focusNode.unfocus();
     
  }

}

  @override
  void initState() {
    
    _controller.text=userStore.userInfo.nickname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Column(
        children: [
          BarNavigation(back: true, title: "Edit nickname"),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(237, 238, 243, 1)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top:15),
            child: InkWell(
                                                onTap: (){
                                                 checkvalid();
                                                 
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: double.infinity,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color:brandBlue,
                                                    borderRadius: BorderRadius.circular(10)
                                                    
                                                  ),
                                                  child: Text(
                                                    "Continue",
                                                    style: TextStyle(
                              color:Colors.white,
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                ),
                                              
                                
                                            ),
          ),
        ],
        
      ),
    );
  }
}