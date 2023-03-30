import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_userside_clone/utils/map_style.dart';
import '../global/global.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(17.3850, 78.4867), zoom: 14);

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            padding:EdgeInsets.only(bottom: 20),
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              newGoogleMapController!.setMapStyle(mapStyle);
              locateUserPosition();
            },
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            compassEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            
          ),
        ],
      );
  
  }
}
