import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:uber_userside_clone/main.dart';


String getCurrentAddressFromSharedPrefs() {
  return sharedPreferences.getString('currentaddress')!;
}

LatLng getCurrentLatLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}