

import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:uber_userside_clone/assistants/requests_assistants.dart';
import 'package:uber_userside_clone/global/global.dart';
import 'package:uber_userside_clone/models/user_model.dart';

class AssistantMethods
{
  
  static Future<String> searchAddressForGeoCoords(Position position) async
  {
    String apiUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/${position.longitude},${position.latitude}.json?access_token=pk.eyJ1Ijoic2Fpa3VtYWFya3VzYW5naSIsImEiOiJjbDhhZGlodDYwOWd6M3VsZjUzMGU1dDhwIn0.S7o9UGqs6tgZsGAmv2ZvtQ";
 String humanReadableAddress = '';
   var requestResponse =  await RequestAssistant.receiveRequest(apiUrl);
   if(requestResponse != "Error occured,Failed. No Response."){
     
    humanReadableAddress = requestResponse['features'][0]['text'] + ', '+ requestResponse['features'][2]['text'];
  }else{
    humanReadableAddress = 'Unable to detect current location!';
  }
  return humanReadableAddress;
  }


  static void readCurrentOnlineuserInfo() async
  {
    currentFirebaseUser = fAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance.
    ref().child('users').
    child(currentFirebaseUser!.uid);

    userRef.once().then((snap){
    
    if (snap.snapshot.value != null) {

    userModelCurrentInfo =   UserModel.fromSnapshot(snap.snapshot);
    
      
    }
    });
  }
}

