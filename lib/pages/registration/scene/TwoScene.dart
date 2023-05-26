import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../helpers/input_number_formetter.dart';

class TwoScene extends StatefulWidget{
  List<TextEditingController> otpController;
  List<FocusNode> otpFocus;
  int otp;
   TwoScene({required this.otp, required this.otpController,required  this.otpFocus, super.key});
  
  @override
  State<StatefulWidget> createState() =>_TwoSceneState();
  
   
  

}

class _TwoSceneState extends State<TwoScene>{
 _TwoSceneState();



  bool errorLen=false;
  
 void _handleFocus(int currentIndex, int nextIndex) {
  if (widget.otpController[currentIndex].text.length!=0){
    widget.otpFocus[currentIndex].unfocus();
    widget.otpFocus[nextIndex].requestFocus();
  }
  
}

  @override
  Widget build(BuildContext context) {

    double winHeight = MediaQuery.of(context).size.height;
    double winWidth = MediaQuery.of(context).size.width;

    return Padding(
                padding: const EdgeInsets.only(top: 4,left: 11,right: 11),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                        children: List.generate(
                            4,
                            (index){
                              return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: winWidth/4-13.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(247,247,253,1),
                              ),
                                child: TextField(
                                  controller: widget.otpController[index],
                                  focusNode: widget.otpFocus[index],
                                   keyboardAppearance: Brightness.dark,
                                  onChanged: (value,) {
                                    print('ee');
                                    if (value.isEmpty && index > 0) {

                                      widget.otpController[index].text = ' ';
                                      _handleFocus(index, index - 1);
                                    } else if (value.isNotEmpty) {
                                      
                                      _handleFocus(index, (index + 1) % 6);

                                    }
                                  },
                                 
                                  textAlign:TextAlign.center, 
                                      maxLength: 1,
                                      style: const TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24,

                                        
                                        
                                    ),
                                  keyboardType: TextInputType.number,
                                  decoration:const  InputDecoration(
                                    
                                      border:InputBorder.none,
                                      counterText: ""
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    
                                  ],
                        ),
                            ),
                          );
                            }
                          )
                        

                      ),
                  ),
                );
  }
}