import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Calendare extends StatefulWidget{
  const Calendare({super.key});
  @override
  State<Calendare> createState() => _CalendareState();
}

class _CalendareState extends State<Calendare> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color:Color.fromRGBO(65, 65, 156, 1),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18,right: 11),
            child: SvgPicture.asset(
                    "assets/svg/calendare.svg"
                    ),
          ),
          Text("Enter date")
        ],
      ),
    );
  }
}