import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonCount extends StatefulWidget{
  const PersonCount({super.key});
  @override
  State<PersonCount> createState() => _PersonCountState();
}

class _PersonCountState extends State<PersonCount> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
         height: 60,
          decoration: BoxDecoration(
            color:Color.fromRGBO(65, 65, 156, 1),
            borderRadius: BorderRadius.circular(10),
    
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19,right: 12),
              child: SvgPicture.asset(
                "assets/svg/person.svg"
              ),
            ),
            Text("1")
          ]
          ),
      ),
    );
  }
}