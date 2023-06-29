import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/menupages/search/from/from.dart';
import 'package:flutter_application_1/menupages/search/map/UI_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSearch extends StatefulWidget{
  Function update;
  MapSearch({required this.update, super.key});

  @override
  State<MapSearch> createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context) {

    MapPage arguments =ModalRoute.of(context)!.settings.arguments as MapPage;

    return Scaffold(
      appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              toolbarHeight: 0,
              toolbarOpacity: 0,
              elevation: 1,
              backgroundColor: Colors.white,
              
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 200, 203, 207),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 22.5,right: 15.5),
                        child: SvgPicture.asset(
                          "assets/svg/back.svg",
                          width: 5,
                          height: 10,
                          color: Color.fromRGBO(58,121,215,1),
                        ),
                      ),
                      Text(
                        "USA, ${arguments.city}",
                        style: TextStyle(
                          color: Color.fromRGBO(87,87,88,1),
                          fontFamily: "Inter",
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),
                        )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: UIMap(
                  city:arguments.city,
                  mapController: _controller, 
                  latitude: double.parse(arguments.latitude) , 
                  longitude: double.parse(arguments.longitude),
                  update:widget.update, 
                  ),
              )
            ],
          )
    );
  }
} 