import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';

class MessagesEmptyState extends StatelessWidget{
  const MessagesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/image/3.png"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Здесь появятся ваши\nбудущие чаты!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "SF",
                color: brandBlack,
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ),
         Container(
          alignment: Alignment.center,
          child: Text(
            "На этой странице вы найдете список ваших будущих чатов с водителем.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "SF",
              color: brandBlack,
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
          ),
        )
      ],
    );
  }

}