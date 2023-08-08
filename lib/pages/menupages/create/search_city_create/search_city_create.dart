
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/http/city/city_model.dart';
import 'package:flutter_application_1/http/city/http_city.dart';
import 'package:flutter_application_1/pages/UI/barNavigation/barNavigation.dart';
import 'package:flutter_application_1/pages/menupages/search/map/map_search.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_webservice/places.dart';

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
  int _availableCityIndex=-1;
  void goToMap(BuildContext context,String placeId,String description,int index)async {

    setState(() {
      _availableCityIndex=index;
    });
    PlacesDetailsResponse details = await places.getDetailsByPlaceId(placeId);
    if(details.errorMessage!=""){
      setState(() {
      _availableCityIndex=-1;
    });
    }
    MapPage params = MapPage(details.result.geometry!.location.lng.toString(), details.result.geometry!.location.lat.toString(), description,);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSearch(update: widget.update,placeId:placeId),
        settings: RouteSettings(arguments: params),
      ),
    );
    setState(() {
      _availableCityIndex=-1;
    });
  }

  final places = GoogleMapsPlaces(apiKey: 'AIzaSyDQ2a3xgarJk8qlNGzNCLzrH3H_XmGSUaY');
  List<Prediction> _cityList=[];
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ArgumentSetting arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentSetting;
   


    void onTextChanged(String text) async{
        if (text.isNotEmpty) {
          PlacesAutocompleteResponse response = await places.autocomplete(
    text,
    language: "us", // Опционально, язык результатов,
    types: ["postal_code","sublocality","administrative_area_level_3","locality","street_address"],
    components: [Component(Component.country, "us")], // Опционально, ограничение результатов по стране
  );
  print(response.predictions);
    setState(() {
      _cityList=response.predictions;
    });
          
          
          
        } else {
          setState(() {
            _cityList = [];
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
        BarNavigation(back: true, title: "Road ${arguments.hint}"),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
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
                                itemCount: _cityList.length,
                                
                                itemBuilder: (context, index) {
                                  List<String> _description= _cityList[index].description!.split(",");

                                  return InkWell(
                                    onTap: () {
                                      if(_availableCityIndex==-1){
                                        goToMap(
                                          context,      
                                          _cityList[index].placeId!,
                                          _cityList[index].description!,
                                          index
                                          );
                                      }
                                      
                                          
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
                                                  _description[0],
                                                  style: const TextStyle(
                                                      fontFamily: "Inter",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          51, 51, 51, 1)),
                                                ),
                                                Text(
                                                  "${_description[2]}, ${_description[1]}",
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
                                              child:_availableCityIndex==index
                                              ? SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Colors.green,
                                                  
                                                ),
                                              ) 
                                              :SvgPicture.asset(
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
