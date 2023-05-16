import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp( const MaterialApp(
    home:  MyApp(),
  ) );
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex=0;
  Color textColor= Colors.white;

 
   
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: const Color.fromRGBO(0, 0, 0, 0)
  )); 

      List<Widget> images=[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Goes to meet people who just got\ntheir license",style: TextStyle(color: textColor,fontFamily: "Inter",fontSize: 18)),
            Padding(padding: EdgeInsets.only(top: 93),child: Image.asset("assets/image/onboard_1.png",fit: BoxFit.cover),) 

          ],
          )
    ,

    Image.asset("image/Onboarding_2.png",fit: BoxFit.cover,),
    Image.asset("image/Onboarding_3.png",fit: BoxFit.cover,),
  ];

    double winHeight = MediaQuery.of(context).size.height;
    return   Scaffold(
        body: Stack(
          alignment: Alignment.bottomRight,
          children:[
            Column(children: [
            SizedBox(
              height: winHeight,
              width: double.infinity,
              child: PageView.builder(
                onPageChanged: (index){
                  setState(() {
                    currentIndex=index%(images.length);
                  });
                },
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(top: 83,left: 15),
                    child: SizedBox(
                      height: winHeight,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your first car without \na driver's license",style: TextStyle(color: textColor,fontSize: 28,fontFamily: "Josefin",fontWeight: FontWeight.w500),),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: images[index%images.length],
                          )
                        ],
                      ) ,
                      
                    ),
                  );
                }
                ),
            ),
            
            // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //   for (var i=0;i< images.length;i++) buildIndicator(currentIndex==i)
          ]),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child:Stack(alignment: Alignment.bottomCenter, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (var i=0;i< images.length;i++) buildIndicator(currentIndex==i),
              
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 11,right: 12),
              child: Container(
                margin: const EdgeInsets.only(top: 10.5, bottom: 100.5),
                child: FilledButton(
                  
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    fixedSize: MaterialStateProperty.all(Size.infinite),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)))
                    
                  ), 
                  child: Container(
                      alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 54,
                    child: const Text(
                      "Next",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(51,51,51,1),
                        fontFamily: "Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                        ),
                      ),
                  ),
                  
                  ),
              ),
            )
                ],
              )
              
            ])
              
          )
          
          ] 
        ),
        backgroundColor: Color.fromRGBO(149,182,255, 1),
      );

  }
  Widget buildIndicator(bool isSelected){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: isSelected? 8:6,
      width: isSelected? 32:6,
      decoration:  BoxDecoration(
        //  border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(79)),
        color: Color.fromRGBO(255, 255, 255, 0.95)
      ),
    );
  }

}