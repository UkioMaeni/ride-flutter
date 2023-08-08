import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_svg/svg.dart';

class MyRoads extends StatefulWidget{
  const MyRoads({super.key});

  @override
  State<MyRoads> createState() => _MyRoadsState();
}

class _MyRoadsState extends State<MyRoads> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/image/my_trips.png"),
            Padding(
              padding: const EdgeInsets.only(top:32,bottom: 12),
              child: Text(
                "Здесь появятся ваши\nзабронированные поездки!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: brandBlack,
                  fontFamily: "SF",
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),
                ),
            ),
              Text(
              "На этой странице вы найдете список ваших\nбудущих путешесвтий, которые вы\nзабонирутете.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: brandBlack,
                fontFamily: "SF",
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
              )
          ],
        ),
      )
    );
  }
}