import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class Mess extends StatelessWidget{
 final Map child;
 const Mess({super.key, required this.child});
  @override
  Widget build(BuildContext context) {

void showAnimation(BuildContext context, img) {
  showDialog(
    barrierColor: Colors.white,
    useSafeArea: false,
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            toolbarOpacity: 0,
            elevation: 1,
            
        ),
        body: Column(
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
              child: Row(
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
                  ClipOval(
                  child: Image.network(
                    img,
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 9,bottom: 9,left: 12),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tom",
                      style: TextStyle(
                        fontFamily: "SF",
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                      ),
                    Text(
                      "Online",
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
                
              ),
            )
          ],
          ),
      );
}
);
}

    return InkWell(
      onTapDown: (details) {
        showAnimation(context,child["img"]);
  },
      child: SizedBox(
        height: 61,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                alignment: Alignment.bottomRight,
              children: [
                ClipOval(
                  child: Image.network(
                    child["img"],
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1
                    )
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12,top: 13.5,bottom: 13.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tom",
                    style: TextStyle(
                      fontFamily: "SF",
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                    ),
                  Text(
                    "Dsdfdsfsdfsdfsd",
                    style: TextStyle(
                      fontFamily: "SF",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color.fromRGBO(0,0,0,0.45)
                    ),
                    )
                ],
              ),
            )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top:13.5),
              child: Column(
                children: [
                  Text(
                    "4:45 PM",
                    style: TextStyle(
                        fontFamily: "SF",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromRGBO(0,0,0,0.65)
                      ),
                    ),
            
                ],
              ),
            )
            
            
          ],
        )
        ),
    );
  }
  
}