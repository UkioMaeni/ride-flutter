
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';

class SearchCard extends StatelessWidget{
  const SearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              spreadRadius: 0,
              blurRadius: 50,
              offset: Offset(0, 10), // смещение тени по горизонтали и вертикали
            ),
      ],
        ),
        height: 193,
        width: double.infinity,
        padding: EdgeInsets.all(14),
        child: Column(
           children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween ,
              children: [
                ////1ый 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: cardSearchGray
                      ),
                      width: 53,
                      height: 14,
                      child: Text(
                        "8 june",
                        style: TextStyle(
                          fontFamily: "SF",
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(51, 51, 51, 1)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "Washington"
                      ),
                    )
                  ],
                ),
                ///1ый
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13,right: 13),
                    child: Container(
                        height: 30,
                        width: double.infinity,
                      child: CustomPaint(
                        
                        painter: DottedLinePainter(
                          color: Color.fromRGBO(217,217,217,1),
                          dotSize: 2,
                          spacing: 2
                        ),
                      ),
                    ),
                  ),
                ),
                ///////3ый 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: cardSearchGray
                      ),
                      width: 53,
                      height: 14,
                      child: Text(
                        "8 june",
                        style: TextStyle(
                          fontFamily: "SF",
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(51, 51, 51, 1)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:4),
                      child: Text(
                        "Washington"
                      ),
                    )
                  ],
                )
                ///3ый
              ],
            ),
            Container(
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: cardSearchGray
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 7),
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(214, 214, 216, 1),
                              borderRadius: BorderRadius.circular(20)
                            ),
                        ),
                      ),
                      Text(
                        "Nick"
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "40,00\$"
                    ),
                  )
                ],
              ),
            )
           ],
        ),
      ),
    );
  }

}



class DottedLinePainter extends CustomPainter {
  final Color color;
  final double dotSize;
  final double spacing;

  DottedLinePainter({required this.color, required this.dotSize, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final dotRadius = dotSize / 2;
    final dotSpacing = dotSize + spacing;
    final dotsCount = (size.width / dotSpacing).ceil();
    final lineWidth = dotSpacing * (dotsCount - 1) + dotSize;

    final startX = (size.width - lineWidth) / 2;
    final startY = size.height / 2;

    for (var i = 0; i < dotsCount; i++) {
      final dotCenter = Offset(startX + dotSpacing * i + dotRadius, startY);
      canvas.drawCircle(dotCenter, dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}