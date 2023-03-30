import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:uber_userside_clone/global/global.dart';

class DemoMaps extends StatefulWidget {
  @override
  _DemoMapsState createState() => _DemoMapsState();
}

class _DemoMapsState extends State<DemoMaps> {
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;
  var lat = 18.0350915;
  var lng = 78.2658285;

  @override
  void initState() {
    super.initState();
    _centerOnLocationUpdate = CenterOnLocationUpdate.always;
    _centerCurrentLocationStreamController = StreamController<double?>();
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            
            Column(
            children: [
              userCurrentPosition != null
                  ? Container()
                  : Text('Location is turned off'),
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(17.3616, 78.4747),
                    zoom: 10,
        
                    // Stop centering the location marker on the map if user interacted with the map.
                    onPositionChanged: (MapPosition position, bool hasGesture) {
                      if (hasGesture) {
                        setState(
                          () => _centerOnLocationUpdate =
                              CenterOnLocationUpdate.never,
                        );
                      }
                    },
                  ),
        
                  // ignore: sort_child_properties_last
                  children: [
                    TileLayer(
                        
                    urlTemplate: "https://api.mapbox.com/styles/v1/saikumaarkusangi/cl8d8vq7l000m14obiwrjdp2n/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2Fpa3VtYWFya3VzYW5naSIsImEiOiJjbDhhZGlodDYwOWd6M3VsZjUzMGU1dDhwIn0.S7o9UGqs6tgZsGAmv2ZvtQ",
                  
                    additionalOptions: {
                       
                        'accessToken':'pk.eyJ1Ijoic2Fpa3VtYWFya3VzYW5naSIsImEiOiJjbDhhZGlodDYwOWd6M3VsZjUzMGU1dDhwIn0.S7o9UGqs6tgZsGAmv2ZvtQ',
                        'id':'mapbox.mapbox-streets-v8'
                    }
                    ),
        
                    //  LocationMarkerLayerWidget(
                    //   plugin:LocationMarkerPlugin(
                    //     centerCurrentLocationStream:  _centerCurrentLocationStreamController.stream,
                    //       centerOnLocationUpdate: _centerOnLocationUpdate,
                    //   ),
                    //   options:LocationMarkerLayerOptions(
                    //     marker:DefaultLocationMarker(
                    //       child:Image.asset('assets/images/bus_logo.png'),
        
                    //     ),
                    //     markerDirection: MarkerDirection.heading
                    //   ) ,
                    //  ),
                    // LocationMarkerLayerWidget(
        
                    //   plugin: LocationMarkerPlugin(
                    //     centerCurrentLocationStream:
                    //         _centerCurrentLocationStreamController.stream,
                    //     centerOnLocationUpdate: _centerOnLocationUpdate,
                    //   ),
                    //   options:LocationMarkerLayerOptions(
                    //     marker: const DefaultLocationMarker(
                    //       color: Colors.blue,
                    //       child:Icon(Icons.headset_sharp)
                    //     ),
                    //     markerSize:const Size(10,10),
                    //     markerDirection: MarkerDirection.heading,
        
                    //   )
                    // ),
                  ],
        
                  nonRotatedChildren: [
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
            Positioned(
                top: 37,
                left: 17,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.black,
                          size: 32,
                        )),
                  ),
                )),
        ]),
      ),
    );
  }
}
