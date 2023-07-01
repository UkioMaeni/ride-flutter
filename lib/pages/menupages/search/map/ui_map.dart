import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UIMap extends StatefulWidget {
 final double latitude;
 final double longitude;
 final Function update;
 final String city;
 final int cityId;
 const UIMap(
      {required this.city,
      required this.update,
      required this.latitude,
      required this.longitude,
      required this.cityId,
      super.key});

  @override
  State<UIMap> createState() => _UIMapState();
}

class _UIMapState extends State<UIMap> {

    final Completer<GoogleMapController> _completer=
      Completer<GoogleMapController>();
    late GoogleMapController _controller;
  double latitudeRide = 0;
  double longitudeRide = 0;
  CameraPosition initial = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    initial = CameraPosition(
        target: LatLng(widget.latitude, widget.longitude), zoom: 16);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMap(
          
          myLocationButtonEnabled: false,
          initialCameraPosition: initial,
          
          mapType: MapType.normal,
          onMapCreated: (controller) async {
            _completer.complete(controller);
            _controller=await _completer.future;
          },
          onCameraIdle: () async {
            final bounds = await _controller.getLatLng(const ScreenCoordinate(x: 0, y: 0));
            setState(() {
              latitudeRide = bounds.latitude;
              longitudeRide = bounds.longitude;
            });
          },

        ),
        SvgPicture.asset("assets/svg/marker.svg"),
        Positioned(
          bottom: 42,
          right: 27,
          child: InkWell(
            onTap: () {
              DataCreate newDate =
                  DataCreate(widget.city, latitudeRide, longitudeRide,widget.cityId);
                  widget.update(newDate);
              Navigator.of(context)
                  .popUntil((route) => route.settings.name == '/menu');
            },
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: const Color.fromRGBO(58, 121, 215, 1)),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}
