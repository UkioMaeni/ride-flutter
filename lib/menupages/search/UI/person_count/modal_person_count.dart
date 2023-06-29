import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

TextStyle localTextStyle = TextStyle(
  color: Color.fromRGBO(58,121,215,1),
  fontFamily: "Inter",
  fontSize: 16,
  fontWeight: FontWeight.w500
);


class ModalPersonCount extends StatefulWidget {
  int count;
  Function increment;
  Function decrement;
  Function setter;
   ModalPersonCount({required this.setter, required this.count,required this.increment, required this.decrement, super.key});


  @override
  _ModalPersonCount createState() => _ModalPersonCount();
}
DateTime date=DateTime.now();


class _ModalPersonCount extends State<ModalPersonCount> {


int count=1;
void _increment(){
  if(count<4){
    setState(() {
    count++;
  });
  }
  
}
void _decrement(){
   if(count>1){
    setState(() {
    count--;
  });
  }
}

@override
  void initState() {
    count=widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        InkWell(
            onTap: (){
              
              Navigator.pop(context);
            },
            child: Container(
              height: 90,
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 12,left: 15,right: 15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                       Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: localTextStyle,
                            ),
                        ),
                        InkWell(
                          onTap: (){
                              widget.setter(count);
                              Navigator.pop(context);
                          },
                          child: Text(
                            "Confirm",
                            style: localTextStyle,
                            ),
                        )
                      ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 20),
                    child: Text(
                      "Колличество\nбронируемых мест",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(51,51,51,1)
                      ),
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          _decrement();
                        },
                        child: SvgPicture.asset(
                          "assets/svg/personMinus.svg",
                            color:count>1?Color.fromRGBO(58,121,215,1):Color.fromRGBO(177,177,177,1),
                        ),
                      ),
                      Text(
                        count.toString(),
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 56,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(51,51,51,1)
                        )
                        ),
                       InkWell(
                        onTap: (){
                          _increment();
                        },
                         child: SvgPicture.asset(
                          "assets/svg/personPlus.svg",
                            color:count<4?Color.fromRGBO(58,121,215,1):Color.fromRGBO(177,177,177,1),
                                             ),
                       )
                    ],
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}