import 'package:ezride/asyncStorage/tokenStorage/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Onboard extends StatefulWidget{
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _MyAppState();
}

class _MyAppState extends State<Onboard> {
  int currentIndex=0;
  Color textColor= Colors.white;
  final PageController controller= PageController();
 
  frameDispatcher()async{
    String refresh =await TokenStorage().getToken("refresh");
    if(refresh!=null){
      
    }
  }
List<Widget> images=[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Goes to meet people who just got\ntheir license",style: TextStyle(color: Colors.white,fontFamily: "Inter",fontSize: 18)),
            Padding(padding: EdgeInsets.only(top: 93),child: Image.asset("assets/image/onboard_1.png",fit: BoxFit.cover),
            ) 
          ],
          )
        , 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Our company is a leader by the\nnumber of cars in the fleet",style: TextStyle(color: Colors.white,fontFamily: "Inter",fontSize: 18)),
            Padding(padding: EdgeInsets.only(top: 104),child: Image.asset("assets/image/onboard_2.png",fit: BoxFit.cover),) 
          ],
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("We will pay for you, all expenses\nrelated to the car",style: TextStyle(color: Colors.white,fontFamily: "Inter",fontSize: 18)),
            Padding(padding: EdgeInsets.only(top: 58),child: Image.asset("assets/image/onboard_3.png",fit: BoxFit.cover),) 
          ],
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Choose between regular car models\nor exclusive ones",style: TextStyle(color: Colors.white,fontFamily: "Inter",fontSize: 18)),
            Padding(padding: EdgeInsets.only(top: 17),child: Image.asset("assets/image/onboard_4.png",fit: BoxFit.cover),) 
          ],
          )
  ];



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: const Color.fromRGBO(0, 0, 0, 0)
  )); 

      

    double winHeight = MediaQuery.of(context).size.height;



    return   Scaffold(
        body: Stack(
          alignment: Alignment.bottomRight,
          children:[
            Column(children: [
            SizedBox(
              height: winHeight,
              width: double.infinity,
              child: NotificationListener<ScrollNotification>(
                
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
                margin: const EdgeInsets.only(top: 10.5),
                child: FilledButton(
                  
                  onPressed: (){
                    if(currentIndex==3){
                      Navigator.popAndPushNamed(context, "/reg");
                    }
                    if(currentIndex<3){
                        controller.jumpToPage(currentIndex+1);
                    }else{
                      frameDispatcher();
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
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 53),
              child: TextButton(
                onPressed: (){
                  Navigator.popAndPushNamed(context, "/reg");
                }, 
                child: Text('Skip',style: TextStyle(
                  color: currentIndex==0?Color.fromRGBO(149,182,255, 1):Colors.white,
                  fontSize:18,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500 
                ),),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(10.5),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  
                  
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
