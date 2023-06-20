import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

CameraPosition _initialPosition =
    CameraPosition(target: LatLng(26.8206, 30.8025));
Completer<GoogleMapController> _controller = Completer();

void _onMapCreated(GoogleMapController controller) {
  _controller.complete(controller);
}

class TestNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          title: Text('Maps in Flutter'),
          centerTitle: true,
        ),
        body: Container(
          width: width,
          height: height,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),
        ));
  }
}
