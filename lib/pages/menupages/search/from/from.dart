
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/city/city_model.dart';
import 'package:flutter_application_1/http/city/http_city.dart';
import 'package:flutter_application_1/pages/menupages/search/map/map_search.dart';
import 'package:flutter_svg/svg.dart';

class ArgumentSetting {
  SvgPicture icon;
  String hint;
  ArgumentSetting(this.icon, this.hint);
}

class MapPage {
  String longitude;
  String latitude;
  String city;
  MapPage(this.longitude, this.latitude, this.city);
}

class SearchFrom extends StatefulWidget {
  final Function update;
  const SearchFrom({required this.update, super.key});

  

  @override
  State<SearchFrom> createState() => _SearchFromState();
}

class _SearchFromState extends State<SearchFrom> {

  void goToMap(BuildContext context, String longitude, String latitude, String city) {
    MapPage params = MapPage(longitude, latitude, city);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSearch(update: widget.update),
        settings: RouteSettings(arguments: params),
      ),
    );
  }


  List<CityModel> cityList = [];
  FocusNode textFocus = FocusNode();
  TextEditingController localController = TextEditingController();
  bool focus = false;

  @override
  void initState() {

    localController.text = "";
    textFocus.requestFocus();
    textFocus.addListener(() {
      if (textFocus.hasFocus) {
        setState(() {
          focus = true;
        });
      } else {
        setState(() {
          focus = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    localController.dispose();
    cityList=[];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ArgumentSetting arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentSetting;
   


    void onTextChanged(String text) async{
        if (text.isNotEmpty) {
          List<CityModel>? newCity = await HttpCity().getCity(text);
          setState(() {
            cityList = newCity!;
          });
          newCity=null;
        } else {
          setState(() {
            cityList = [];
          });
        }
        
      
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
        body: Column(
          children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/svg/back.svg"),
              ),
            ),
            Container(
              height: 24,
              alignment: Alignment.center,
              child: const Text(
                "Road from",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter"),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: categorySelected,
                    borderRadius: BorderRadius.circular(10)),
                height: 60,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 9),
                      child: arguments.icon,
                    ),
                    Expanded(
                      child: TextField(
                        controller: localController,
                        focusNode: textFocus,
                        textInputAction: TextInputAction.done,
                        onChanged: onTextChanged,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                            hintText: arguments.hint,
                            border: InputBorder.none,
                            counterText: ""),
                      ),
                    ),
                  ],
                ),
              ),
              focus
                  ?localController.text.isEmpty
                  ? arguments.hint=="from"? SizedBox(
                          height: 44,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4, right: 10),
                                child:
                                    SvgPicture.asset("assets/svg/geo.svg"),
                              ),
                              const Text("Use my geolocation"),
                            ],
                          )):Container()
                      : SingleChildScrollView(
                          child: SizedBox(
                              height: 215,
                              child: ListView.builder(
                                itemCount: cityList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      goToMap(
                                          context,
                                          cityList[index].longitude,
                                          cityList[index].latitude,
                                          cityList[index].city);
                                    },
                                    child: SizedBox(
                                        height: 43,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cityList[index].city,
                                                  style: const TextStyle(
                                                      fontFamily: "Inter",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          51, 51, 51, 1)),
                                                ),
                                                Text(
                                                  "USA, ${cityList[index].state}",
                                                  style: const TextStyle(
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          119,
                                                          119,
                                                          119,
                                                          1)),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(
                                                      right: 4),
                                              child: SvgPicture.asset(
                                                  "assets/svg/upToMap.svg"),
                                            )
                                          ],
                                        )),
                                  );
                                },
                              )),
                        ):Container()
            ],
          ),
        )
          ],
        ));
  }
}
