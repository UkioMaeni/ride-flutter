import 'package:easy_debounce/easy_debounce.dart';
import 'package:ezride/helpers/color_constants.dart';
import 'package:ezride/http/city/city_model.dart';
import 'package:ezride/http/city/http_city.dart';
import 'package:ezride/pages/mainapp/menupages/search/map/map_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ArgumentSetting{
SvgPicture icon;
String hint;
TextEditingController controller;
  ArgumentSetting( this.icon,this.hint,this.controller);
}

class MapPage{
  String longitude;
  String latitude;
  String city;
  MapPage(this.longitude,this.latitude,this.city);
}




class SearchFrom extends StatefulWidget{
  Function update;
   SearchFrom({required this.update, super.key});

  void goToMap(BuildContext context,String longitude, String latitude,String city) {
    MapPage params= MapPage(longitude,latitude,city);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSearch(update: update),
        
        settings: RouteSettings(arguments:params), 
      ),
  );
}
  @override
  State<SearchFrom> createState() => _SearchFromState();
}

class _SearchFromState extends State<SearchFrom> {
  List<CityModel> cityList=[];
  final FocusNode textFocus = FocusNode();
  TextEditingController localController = TextEditingController();
  bool focus=false;
  
@override
  void initState() {
    localController.text="";
    textFocus.addListener(() {
  if (textFocus.hasFocus) {
    print("focused");
    setState(() {
      focus=true;
    });
  } else {
    setState(() {
      focus=false;
    });
  }

  });
    print(focus);
    super.initState();
  }
@override
  void dispose() {
    localController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ArgumentSetting arguments = ModalRoute.of(context)!.settings.arguments as ArgumentSetting;
    WidgetsBinding.instance.addPostFrameCallback((_) => textFocus.requestFocus());
    void _onTextChanged(String text) {
      print(arguments.controller.text.length);
    fn()async{
      if(text.length>0){
        List<CityModel> newCity= await HttpCity().getCity(text);
        setState(() {
       cityList=newCity;
        });
      }else{
        setState(() {
          cityList=[];
        });
      }
     
     
    } 
    EasyDebounce.debounce("one", const Duration(milliseconds: 300), ()=>fn());
    
}

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
                                      color: categorySelected,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                            height: 60,
                            child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:16,right: 9 ),
                                      child: arguments.icon,
                                      ),
                                    
                                    Expanded(
                                      child: TextField(
                                        focusNode: textFocus,
                                        onChanged: _onTextChanged,
                                        controller: arguments.controller,
                                        textCapitalization: TextCapitalization.sentences,
                                        keyboardType: TextInputType.text,
                                        style:const  TextStyle(
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            
                                        ),
                                        decoration:  InputDecoration(
                                          hintText: arguments.hint,
                                          border:InputBorder.none,
                                          counterText: ""
                                        ),                   
                                      ),
                                      ),
                                  ],
                            ),
                          ),
                          focus
                          ?arguments.controller.text.isEmpty
                          ?Container(
                                        height: 44,
                                        color: Colors.amber,
                                        child:Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4,right: 10),
                                              child: SvgPicture.asset(
                                                "assets/svg/geo.svg"
                                              ),
                                            ),
                                            Text("Use my geolocation"),
                                          ],
                                        )  
                                      )
                          :SingleChildScrollView(
                            child: Container(
                              height: 215,
                                  child: ListView.builder(
                                    itemCount: cityList.length,
                                    itemBuilder: (context, index) {
                                      return  InkWell(
                                        onTap:() {
                                          arguments.controller.clear();
                                           widget.goToMap(context,cityList[index].longitude,cityList[index].latitude,cityList[index].city);
                                        },
                                        child: SizedBox(
                                          height: 43,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  
                                                  Text(
                                                    cityList[index].city,
                                                    style: TextStyle(
                                                      fontFamily: "Inter",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color.fromRGBO(51,51,51,1)
                                                    ),
                                                    ),
                                                    Text(
                                                    "USA, ${cityList[index].state}",
                                                    style: TextStyle(
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color.fromRGBO(119, 119, 119,1)
                                                    ),
                                                    ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 4),
                                                child: SvgPicture.asset(
                                                  "assets/svg/upToMap.svg"
                                                ),
                                              )
                                            ],
                                          )
                                        ),
                                      );
                                    },
                                  )
                              
                            ),
                          ):Container()
                          ],
                              ),
                        )
                      ],
                    )
                  )
                );
  }
}