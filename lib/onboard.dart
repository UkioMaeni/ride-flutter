
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/localization/localization.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/loader/loader.dart';
import 'package:flutter_application_1/registration/registration.dart';
import 'package:flutter_svg/flutter_svg.dart';



class Onboard extends StatefulWidget{
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _MyAppState();
}

class _MyAppState extends State<Onboard> {
  int currentIndex=0;
  Color textColor= Colors.white;
  final PageController controller= PageController();

  bool initialize=false;
 
 
List<String> upText=[
"Looking for a ride?",
"\"Where are you going?\" \"Got some empty seats?\" \"It's easy!\"",
"Found your ride?",
"Accepted passengers already?"

];

List<Widget> images=[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Find a ride with verified profiles. Choose a car model and comfortable time for your ride. It's easy",style: TextStyle(color: Colors.white,fontFamily: "SF",fontSize: 18,fontWeight: FontWeight.w400)),
            Padding(padding: const EdgeInsets.only(top: 20),child: appAssets.onBoard4,
            ) 
          ],
          )
        , 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create a ride. Choose the number of passengers",style: TextStyle(color: Colors.white,fontFamily: "SF",fontSize: 18,fontWeight: FontWeight.w400)),
            Padding(padding: const EdgeInsets.only(top: 50),child: appAssets.onBoard2,) 
          ],
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Meet a driver at the agreed time and location",style: TextStyle(color: Colors.white,fontFamily: "SF",fontSize: 18,fontWeight: FontWeight.w400)),
            Padding(padding: const EdgeInsets.only(top: 80),child: appAssets.onBoard3) 
          ],
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Meet them at the agreed time and location",style: TextStyle(color: Colors.white,fontFamily: "SF",fontSize: 18,fontWeight: FontWeight.w400)),
            Padding(padding: const EdgeInsets.only(top: 90),child: appAssets.onBoard1,)
          ],
          )
  ];

  TextEditingController _myController=TextEditingController();
  @override
  void initState() {
    _myController.text=appCode;
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    images=[];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: const Color.fromRGBO(0, 0, 0, 0)
  )); 

      final localizationManager = Localizations.of<LocalizationManager>(context, LocalizationManager);
      

    double winHeight = MediaQuery.of(context).size.height;



    return   Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: images.length,
              controller: controller,
              onPageChanged: (index){
                setState(() {
                  currentIndex=index%(images.length);
                });
              },
              itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(top: 50,left: 15),
                        child: SizedBox(
                          height: winHeight,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(upText[index],style: TextStyle(color: textColor,fontSize: 28,fontFamily: "SF",fontWeight: FontWeight.w700),),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: images[index%images.length],
                              )
                            ],
                          ) ,
                          
                        ),
                      );
              }
              ),
          ),
          Column(
            children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (var i=0;i< images.length;i++) buildIndicator(currentIndex==i)
                ]),
                 Padding(
              padding: const EdgeInsets.only(left: 11.5,right: 11.5),
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: FilledButton(
                  
                  onPressed: (){
                    if(currentIndex==3){
                      Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => Registration()),
                      (route) => false,);
                    }
                    if(currentIndex<3){
                        controller.jumpToPage(currentIndex+1);
                    }
                    
                  
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    fixedSize: MaterialStateProperty.all(Size.infinite),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)))
                    
                  ), 
                  child: Container(
                      alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 64,
                    child:  Text(
                      "Next",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: brandBlue,
                        fontFamily: "SF",
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                        ),
                      ),
                  ),
                  
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TextButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => Registration()),
                      (route) => false,);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10.5),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ), 
                child: Text('Skip',style: TextStyle(
                  color: currentIndex==0?Color.fromRGBO(149,182,255, 1):Colors.white,
                  fontSize:18,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500 
                ),),
                ),
            )
            ],
            
          )
        ],
      ),
        // body: Column(
        //  // alignment: Alignment.bottomCenter,
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children:[
        //     Column(children: [
        //     SizedBox(
        //       height: winHeight,
        //       width: double.infinity,
        //       child: NotificationListener<ScrollNotification>(
                
        //         child: PageView.builder(
        //           itemCount: images.length,
        //           controller: controller,
        //           onPageChanged: (index){
        //             setState(() {
        //               currentIndex=index%(images.length);
        //             });
        //           },
        //           itemBuilder: (context,index){
        //             return Padding(
        //               padding: const EdgeInsets.only(top: 83,left: 15),
        //               child: SizedBox(
        //                 height: winHeight,
        //                 width: MediaQuery.of(context).size.width,
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text("Your ${localizationManager?.translate("test")} first car without \na driver's license",style: TextStyle(color: textColor,fontSize: 28,fontFamily: "SF",fontWeight: FontWeight.w700),),
        //                     Padding(
        //                       padding: const EdgeInsets.only(top: 12),
        //                       child: images[index%images.length],
        //                     )
        //                   ],
        //                 ) ,
                        
        //               ),
        //             );
        //           }
        //           ),
        //       ),
        //     ),
            
        //     // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //     //   for (var i=0;i< images.length;i++) buildIndicator(currentIndex==i)
        //   ]),
        //   SizedBox(
        //     width: MediaQuery.of(context).size.width,
        //     child:Column(
        //      // alignment: Alignment.bottomCenter, 
        //      mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       for (var i=0;i< images.length;i++) buildIndicator(currentIndex==i),
              
        //     ]),
        //     Padding(
        //       padding: const EdgeInsets.only(left: 11.5,right: 11.5),
        //       child: Container(
        //         margin: const EdgeInsets.only(top: 10),
        //         child: FilledButton(
                  
        //           onPressed: (){
        //             if(currentIndex==3){
        //               Navigator.pushAndRemoveUntil(context,
        //               MaterialPageRoute(builder: (context) => Registration()),
        //               (route) => false,);
        //             }
        //             if(currentIndex<3){
        //                 controller.jumpToPage(currentIndex+1);
        //             }
                    
                  
        //           },
        //           style: ButtonStyle(
        //             backgroundColor: MaterialStateProperty.all(Colors.white),
        //             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //             fixedSize: MaterialStateProperty.all(Size.infinite),
        //             shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)))
                    
        //           ), 
        //           child: Container(
        //               alignment: Alignment.center,
        //             width: MediaQuery.of(context).size.width,
        //             height: 64,
        //             child:  Text(
        //               "Next",
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                 color: brandBlue,
        //                 fontFamily: "SF",
        //                 fontSize: 16,
        //                 fontWeight: FontWeight.w700
        //                 ),
        //               ),
        //           ),
                  
        //           ),
        //       ),
        //     ),
        //     // Container(
        //     //   height: 80,
        //     //   child: TextField(
        //     //     controller: _myController,
        //     //   ),
        //     // ),
        //     Padding(
        //       padding: const EdgeInsets.only(bottom: 84),
        //       child: TextButton(
        //         onPressed: (){
        //           Navigator.pushAndRemoveUntil(context,
        //               MaterialPageRoute(builder: (context) => Registration()),
        //               (route) => false,);
        //         },
        //         style: TextButton.styleFrom(
        //           padding: const EdgeInsets.all(10.5),
        //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //           ), 
        //         child: Text('Skip',style: TextStyle(
        //           color: currentIndex==0?const Color.fromRGBO(149,182,255, 1):Colors.white,
        //           fontSize:18,
        //           fontFamily: "Poppins",
        //           fontWeight: FontWeight.w500 
        //         ),),
        //         ),
        //     )
        //         ],
        //       )
              
        //     ])
              
        //   )
          
        //   ] 
        // ),
        backgroundColor: const Color.fromRGBO(149,182,255, 1),
      );

  }
  Widget buildIndicator(bool isSelected){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: isSelected? 8:6,
      width: isSelected? 32:6,
      decoration:  const BoxDecoration(
        //  border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(79)),
        color: Color.fromRGBO(255, 255, 255, 0.95)
      ),
    );
  }

}
