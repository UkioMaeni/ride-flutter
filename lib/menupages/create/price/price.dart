
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/pages/mainapp/create/provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Price extends StatefulWidget{
  const Price({super.key});

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {

  TextEditingController priceController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        toolbarOpacity: 0,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);


                    },
                    child: SvgPicture.asset(
                    "assets/svg/back.svg",
                    height: 12,
                    width: 6,
                                  ),
                  ),
                ),
                Align(
                alignment: Alignment.center,
                child: Text(
                  "Стоимость",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(51, 51, 51, 1),
                  ),
                ),
              ),
        ],
      ),
      ),
          Padding(
            padding: const EdgeInsets.only(top: 40,bottom: 24),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
                  decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Color.fromRGBO(233,235,238, 1),
                width: 1,
                style: BorderStyle.solid
              )
              )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 13),
                            child: SvgPicture.asset(
                                                  "assets/svg/geo.svg",
                                                  height: 20,
                                                  width: 14,
                                                ),
                          ), 
                      Text(
                        "dddddd",
                        style: currentTextStyle,
                        )
                        ],
                      ),
                      // Иконка 1// Промежуток между иконками
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Container(
                            width: 1, // Ширина линии
                            height: 25, // Высота линии
                            child: CustomPaint(
                              painter: DashedLinePainter(), // Класс, реализующий отрисовку пунктирной линии
                            ),
                          ),
                      ),// Промежуток между иконками
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 13),
                            child: SvgPicture.asset(
                                                  "assets/svg/geo.svg",
                                                  height: 20,
                                                  width: 14,
                                                ),
                          ), 
                      Text(
                        "dddddd",
                        style: currentTextStyle,
                        )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28),
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          decoration: BoxDecoration(
                            color: categorySelected,
                            borderRadius: BorderRadius.circular(10)
                      
                          ),
                          child: TextField(
                            controller: priceController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Укажите сумму поездки",
                              contentPadding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                            ),
                            
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          ),
                        ),
                      )
                    ],
                  ),

            ),
          ),
          Container(
            height: 74,
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(58,121,215,1)),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12,right: 16),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: categorySelected,
                          borderRadius: BorderRadius.circular(25)
                        ),
                          child: SvgPicture.asset(
                            "assets/svg/money.svg",
                            fit: BoxFit.scaleDown,
                          ),
                      ),
                    ),
                    Text(
                      "Наличка"
                    )
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: Container(
                      height: 18,
                      width: 18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(58,121,215,1),
                        borderRadius: BorderRadius.circular(9)
                      ),
                      child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)
                          ),
                      ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 9.33),
                  child: SvgPicture.asset(
                    "assets/svg/information.svg"
                  ),
                ),
                Expanded(
                  child: Text(
                    "Оплата только наличными после завершения поездки",
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
           Padding(
              padding: const EdgeInsets.only(top:26),
              child: InkWell(
                onTap: (){
                  String price= priceController.text;
                 Provider.of<CreateProvider>(context,listen: false).setPrice(price);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:Color.fromRGBO(64,123,255,1),
                    borderRadius: BorderRadius.circular(10)
                    
                  ),
                  child: Text(
                    "Продолжить",
                    style: TextStyle(
                      color: Color.fromRGBO(255,255,255,1),
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey // Цвет линии
      ..strokeWidth = 1 // Толщина линии
      ..style = PaintingStyle.stroke;

    final dashWidth = 5; // Ширина пунктира
    final dashSpace = 3; // Расстояние между пунктирами

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) => false;
}

TextStyle currentTextStyle= TextStyle(
  fontFamily: "Inter",
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Color.fromRGBO(51, 51, 51, 1)
);