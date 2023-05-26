import 'package:easy_debounce/easy_debounce.dart';
import 'package:ezride/helpers/debounce.dart';
import 'package:ezride/http/city/city_model.dart';
import 'package:ezride/http/city/http_city.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class TextInput extends StatefulWidget{
 final SvgPicture icon;
 final String hint;
 TextEditingController controller;
TextInput({required this.controller, required this.icon,required this.hint, super.key});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {

List<CityModel> cityList=[];

void _onTextChanged(String text) {
    fn()async{
     List<CityModel> newCity= await HttpCity().getCity(text);
     setState(() {
       cityList=newCity;
     });
    } 
    fn();
    //EasyDebounce.debounce("one", const Duration(milliseconds: 300), ()=>fn());
    
}

void _showAnimation(BuildContext context) {
  showDialog(
    barrierColor: Colors.white,
    useSafeArea: false,
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      
      return StatefulBuilder(
        builder: (context, setState){
          return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              toolbarHeight: 0,
              toolbarOpacity: 0,
              elevation: 1,
              backgroundColor: Colors.white,
              
          ),
                  body: Container(
                    child:Column(
                      children: [
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                  "assets/svg/back.svg"
                                ),
                              ),
                            ),
                             Container(
                                height: 24,
                                alignment: Alignment.center,
                                child: Text(
                                  "Road from",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Inter"
                                  ),
                                  ),
                              ),
                          ],
                        ),
                        Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 162, 173, 182),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                            height: 60,
                            child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:16,right: 9 ),
                                      child: widget.icon,
                                      ),
                                    
                                    Expanded(
                                      child: TextField(
                                        onChanged: _onTextChanged,
                                        controller: widget.controller,
                                        textCapitalization: TextCapitalization.sentences,
                                        keyboardType: TextInputType.text,
                                        style:const  TextStyle(
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            
                                        ),
                                        decoration:  InputDecoration(
                                          hintText: widget.hint,
                                          border:InputBorder.none,
                                          counterText: ""
                                        ),                   
                                      ),
                                      ),
                                  ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              height: 120,
                                  child: ListView.builder(
                                    itemCount: cityList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 60,
                                        child: Text(cityList[index].city),
                                      );
                                    },
                                  ),
                              
                            ),
                          ),
                          ],
                              ),
                        )
                      ],
                    )
                  )
                );
        },
      
      );
    },
  );
}





  @override
  Widget build(BuildContext context) {
   return GestureDetector(
      onTapDown: (details) {
        Offset tapPosition = details.globalPosition;
        _showAnimation(context);
  },
     child: Container(
              height: 60,
              decoration: BoxDecoration(
                //color: Color.fromRGBO(247,247,253,1),
                color: Color.fromRGBO(65, 65, 156, 1),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 9),
                    child: widget.icon
                  ),
                   Text("${widget.hint}")
                ],
              ),
             ),
   );
  }
}

