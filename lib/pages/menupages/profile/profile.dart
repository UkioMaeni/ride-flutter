
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/user/http_user.dart';
import 'package:flutter_application_1/pages/UI/popup/popup.dart';
import 'package:flutter_application_1/pages/UI/user_car.dart';
import 'package:flutter_application_1/pages/menupages/profile/PDFViewer/PDFWiewer.dart';
import 'package:flutter_application_1/pages/menupages/profile/Paragraf/paragraf.dart';
import 'package:flutter_application_1/pages/menupages/profile/Punkt/punkt.dart';
import 'package:flutter_application_1/localStorage/tokenStorage/token_storage.dart';
import 'package:flutter_application_1/pages/menupages/profile/editProfile/edit_profile.dart';
import 'package:flutter_application_1/pages/menupages/provider/user_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';


 

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

 




class _ProfileState extends State<Profile> {

  
   void share(){
    Share.share('Download EasyRide');
   }



List list=[];


@override
  void initState() {

    list.addAll(
      [
  
  const Paragraf(paragraf: "Additionally"),
  Punkt(punkt: "Privacy Policy",onTap: (context){

    Navigator.push(context, MaterialPageRoute(builder: (context) => PDFWiewer(pdftype: PDFTYPE.policy),));
  }),
  Punkt(punkt: "Terms of Use",onTap: (context)async{

      Navigator.push(context, MaterialPageRoute(builder: (context) => PDFWiewer(pdftype: PDFTYPE.condition),));
  }),
  //Punkt(punkt: "Invite friends",onTap: share),
  //Punkt(punkt: "Rate the application",onTap: (context){}),
  Punkt(warning: true, punkt: "Delete account",onTap: (context){
     showDialog(
          context: context, 
          builder: (context){
            return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: AppPopup(warning:true, title: "Delete account", description: "Are you sure you want to delete your account?\nAll data will be deleted!", pressYes: ()async{
                      
                      int result = await HttpUser().deleteUser();
                      if(result==0){
                          userStore.userInfo.auth=false;
                          TokenStorage().clearSharedPreferences().then((_){
                            Navigator.pushNamedAndRemoveUntil(context,"/reg",(route)=>false);
                      });
                      }else{
                          Navigator.pop(context);
                      }
                      
                    }, pressNo: ()=>Navigator.pop(context)),
                    );
          }
          );
  }),
  
]

    );

    if(userStore.userInfo.auth){
      list.add(  Paragraf(paragraf: "Exit",onTap: (context){
    userStore.userInfo.auth=false;
   TokenStorage().clearSharedPreferences().then((_){
    Navigator.pushNamedAndRemoveUntil(context,"/reg",(route)=>false);
   });
 },));
    }
    if(userStore.userInfo.auth){
      list.insertAll(
        0, 
        [
          const Paragraf(paragraf: "For drivers"),
  Punkt(punkt: "My cars",onTap: (context){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => UserAutoUI()));
  },),]
  );
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          
           Padding(
            padding: EdgeInsets.only(top: 24,left: 15,right: 15),
            child: userPermission(),
          ),
         Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder:(context, index) {
              return list[index];
            },
            ),
         ),
          
        
        ],
      );
  }

  Widget userPermission(){
    return InkWell(
      onTap: () {
        if(!userStore.userInfo.auth){
          Navigator.pushNamedAndRemoveUntil(context,"/reg",(route)=>false);
        }else{
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => EditProfile(),));
        }
      },
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Color.fromRGBO(243, 246, 255, 1),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: Container(
                    alignment: Alignment.center,
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: brandBlue,
                      borderRadius: BorderRadius.circular(28)
                    ),
                    child: SvgPicture.asset("assets/svg/userIcon.svg"),
                  ),
                ),
                Observer(
                  
                  builder: (context) {
                    bool auth=userStore.userInfo.auth;
                    print(auth);
                    return Text(
                      auth
                      ?userStore.userInfo.nickname
                      :"Sign in / Log in",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "SF",
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                      ),
                    );
                    
                  },
                  )
              ],
            ),
            Observer(
              builder: (context) {
                 bool auth=userStore.userInfo.auth;
                return  Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset("assets/svg/chevron-left.svg",color: brandBlue,),
            );
              },
              )
          ],
        ),
      ),
    );
  }
}