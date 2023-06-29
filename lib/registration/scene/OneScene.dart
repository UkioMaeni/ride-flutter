import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../helpers/input_number_formetter.dart';

class OneScene extends StatefulWidget{

  TextEditingController controller;
   OneScene({required this.controller,super.key});
  
  @override
  State<StatefulWidget> createState() =>_OneSceneState();
  
   
  

}

class _OneSceneState extends State<OneScene>{
 _OneSceneState();

  FocusNode _focusNode=FocusNode();
  bool _isFocused = false;
  bool errorLen=false;
  @override
  void initState() {
    super.initState();
   
    _focusNode.addListener(_onFocusChange);
  }
    @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }
 

  @override
  Widget build(BuildContext context) {

    double winHeight = MediaQuery.of(context).size.height;
    double winWidth = MediaQuery.of(context).size.width;

    return Padding(
                padding:  EdgeInsets.only(top: 4),
                child: SizedBox(
                  width: winWidth-30,
                  child: Container(
                    height: 60,
                    decoration:  BoxDecoration(
                      color:  Color.fromRGBO(247,247,253,1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: 1.6,
                        color:errorLen
                        ? Color.fromRGBO(255,152,152,1)
                        :_isFocused
                        ?Colors.blue
                        :Colors.white
                      )
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2.0),
                            child: Image.asset("assets/image/flagUSA.png",)
                          ),
                        ),
                        const Padding(
                          padding:  EdgeInsets.only(left: 4),
                          child:  Text(
                            "+1 ",
                            style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13
                              ),
                            ),
                        ),
                       
                        Container(
                          height: 60,
                          width: 250,
                          alignment: Alignment.center,
                          child: TextField(
                            focusNode: _focusNode,
                            controller:widget.controller,
                            maxLength: 16,
                            textInputAction: TextInputAction.done,
                            
                            style:const  TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                
                            ),
                            keyboardType: TextInputType.phone,
                            decoration:const  InputDecoration(
                              border:InputBorder.none,
                              counterText: ""
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              NumberFormatter(maxLength: 16)
                              
                            ],
                            
                            onChanged: (value) =>{
                              setState((){
                                errorLen=false;
                              })
                            },
                          ),
                        )
                        
                      ],
                    ),
                  ),
                ),
              );
  }
}