import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/http/reg/http_reg.dart';
import 'package:flutter_application_1/http/token/http_token.dart';
import 'package:flutter_application_1/http/user/http_user.dart';
import 'package:flutter_application_1/registration/scene/one_scene.dart';
import 'package:flutter_application_1/registration/scene/two_scene.dart';
import 'package:flutter_application_1/registration/scene/third_scene.dart';
import 'package:flutter_application_1/tokenStorage/token_storage.dart';




class Registration extends StatefulWidget{
  const Registration({super.key});

  @override
  State<Registration> createState() => _MyAppState();
}

class _MyAppState extends State<Registration> {

 void  isAuth(BuildContext context)async{
  String next=await HttpToken().refreshToken();
  String token=await TokenStorage().getToken("refresh");
  if(next=="auth" && token !="no"){
    Navigator.pushReplacementNamed(context,"/menu" );
  }
 } 
   //TEMP
  int otp=0;

  ////required data
  //1scene
  TextEditingController myControllerOneScene=TextEditingController();

  //2scene
  List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  List<FocusNode> otpFocusNodes = List.generate(
  6,
  (index) => FocusNode(),
  );
  //3scene
  TextEditingController myControllerThirdScene=TextEditingController();


  String otpCode = '';
  String numbers="";
  bool errorLen=false;
  
  int step=0;
  

  
  correctText() async{

      if(myControllerOneScene.text.length!=16){
        setState(() {
          errorLen=true;
        });
        return;
      }
      if(step==0) {
   
        String digitsOnly = myControllerOneScene.text.replaceAll(RegExp(r'[^0-9]'), '');
        digitsOnly="+1$digitsOnly";
       Map code= await HttpReg().signIn(digitsOnly);
       setState(() {
         otp=code["otp"];
         step=1;
       });
        
      return;
      }

      if(step==1){
        String codeStr=otpControllers[0].text+otpControllers[1].text+otpControllers[2].text+otpControllers[3].text;
        int code = int.parse(codeStr);
        String phone = myControllerOneScene.text.replaceAll(RegExp(r'[^0-9]'), '');
        phone="+1$phone";

        Map tokens = await HttpReg().otpVerify(code,phone);
         await TokenStorage().setToken(tokens["access_token"],tokens["refresh_token"]);
          setState(() {
            step=2;
          });
        
        return;
      }
      if(step==2){
       int response =await HttpUser().postUser(myControllerThirdScene.text);
       if(response==0){
        Navigator.pushReplacementNamed(context, "/menu");
       }
      }
      
  }

  @override
  void initState() {
    isAuth(context);
    super.initState();
  }
  @override
  void dispose() {
    myControllerOneScene.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: const Color.fromRGBO(0, 0, 0, 0),
      statusBarBrightness: Brightness.light
  )); 

   
    double winWidth = MediaQuery.of(context).size.width;


    return   Scaffold(
      appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          toolbarOpacity: 0,
          elevation: 1,
          
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        width: winWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: winWidth,
              padding: const EdgeInsets.only( top: 20,bottom: 20,left: 15),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  step!=0?TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.white)
                      ),
                  onPressed: (){
                    setState(() {
                      step-=1;
                    });
                  },
                   child:const Text(
                    "Back",
                    style:  TextStyle(
                      color: Color.fromRGBO(64,123,255,1),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),
                    ),
                   ):const Offstage(),
                   Container(
                    alignment: Alignment.center,
                    child: Image.asset('assets/image/reg.png')
                    ),
                ],
              )
            ),
            
            SizedBox(
              width: winWidth-30,
              child:  Text(
                step==0
                ?"Your phone number"
                :step==1
                ?"OTP Verification(code $otp)"
                :"How do I address you?",
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 13
                ),
                )
              ),
              step==0
              ?OneScene(controller: myControllerOneScene)
              :step==1
              ?TwoScene(otpController: otpControllers, otpFocus: otpFocusNodes,otp:otp)
              :ThirdScene(controller: myControllerThirdScene),
               errorLen? Container(
                alignment: Alignment.bottomLeft,
                child:const Padding(
                  padding:  EdgeInsets.only(left: 23,top: 4),
                  child: Text(
                    "Invalid phone number",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,

                    ),
                    ),
                )
                ):Container(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                    child:  FilledButton(
                        onPressed: (){
                          correctText();
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )),
                          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(64,123,255,1))
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          child:   Text(
                             step==0?"Get code":"Continue",
                            style:  const TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                            ),
                          ),
                        )
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.white)
                    ),
                    onPressed: (){},
                    child:  const Text(
                      "Skip",
                      style: TextStyle(
                        color: Color.fromRGBO(64,123,255,1),
                        fontFamily: "Inter",
                        fontSize: 16,
                        
                        fontWeight: FontWeight.w600
                      ),
                      )
                    )
                ],
                
              )
          ],
        ),
      ),
    );
}

}
