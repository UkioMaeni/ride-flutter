
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Punkt extends StatelessWidget   {
  String punkt;
  Function OnTap;
  Punkt({required this.OnTap, required this.punkt, Key?key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 22.5),
      child: GestureDetector(
        onTap: ()=>OnTap(),
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(233,235,238,1),
                width: 1,
                style: BorderStyle.solid
              )
            )
          ),
          height: 53,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                punkt,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(51, 51, 51, 1)
                ),
              ),
              SvgPicture.asset(
                "assets/svg/upToMap.svg",
                color: Color.fromRGBO(173,179,188,1),
              ),
            ],
          ),
        ),
      ),
    );


  }
}