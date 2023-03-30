import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_userside_clone/models/user_model.dart';
import 'package:uber_userside_clone/screens/homeScreen.dart';
import 'package:uber_userside_clone/screens/userdata.dart';
import '../assistants/assistant_methods.dart';
import '../authentication/signin_screen.dart';
import '../main.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
final userRef = FirebaseDatabase.instance.ref().child('users');

UserModel? userModelCurrentInfo;
var mobilenumber = '';

String Countrycode = '+91';  
GoogleMapController? newGoogleMapController;
Position? userCurrentPosition;
var geolocator = Geolocator();

class FirebaseService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
 
  Future<String?> signInwithGoogle() async {
    try 
  {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await fAuth.signInWithCredential(credential);
      currentFirebaseUser = fAuth.currentUser;
       userRef.child(fAuth.currentUser!.uid).once().then((userKey)
        {
                final snap = userKey.snapshot;
                    if(snap.value != null)
                    {
                       Get.toNamed('/mainScreen');
                      }else{
                           Get.toNamed('/userScreen');
                          }
        });
    } on FirebaseAuthException {
         rethrow;
       }
  }

  Future<void> signOutFromGoogle() async
  {
    await googleSignIn.signOut();
    currentFirebaseUser = null; 
  }
}

signOut() async
{
 FirebaseService service = FirebaseService();
   await service.signOutFromGoogle();
    await fAuth.signOut();
    currentFirebaseUser = null;
    Get.toNamed('/signinScreen');
}


SignIn()async

{
  try {                   
     await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${Countrycode.toString()+mobilenumber}',
        verificationCompleted: ((phoneAuthCredential) {
          
        }),
      
        verificationFailed: (FirebaseAuthException e) {
        
        }, 
        codeSent: (String verificationId,int? resendToken){
           Fluttertoast.showToast(
            msg:'otp sent..'
           );
           SignInScreen.verify = verificationId;
           currentFirebaseUser = fAuth.currentUser;
           
          Get.toNamed('/otpScreen',arguments: {'mobilenumber ':mobilenumber});
        }, 
        codeAutoRetrievalTimeout: (String verificationId)  {} 
        );
  } catch (e) 
  {
     Fluttertoast.showToast(
    msg:e.toString());
  }
     
}

locateUserPosition() async
 {  

 LocationPermission permission;
   permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
       
        return Fluttertoast.showToast(msg: 'Location Permisson are denied');
      }
    }
   Position cPostion =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   userCurrentPosition = cPostion;
 

  String humanReadableAddress = await AssistantMethods.searchAddressForGeoCoords(userCurrentPosition!);
   
   LatLng latLngPosition = LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
    sharedPreferences.setDouble('latitude', userCurrentPosition!.latitude);
    sharedPreferences.setDouble('longitude',  userCurrentPosition!.longitude);
   
   CameraPosition cameraPosition = CameraPosition(target: latLngPosition,zoom: 18);

  newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    

      sharedPreferences.setString('currentaddress', humanReadableAddress);
    
     
    
  
 }

 Future<Position> locationPermission() async{
   

    return await Geolocator.getCurrentPosition();
  }


greeting(){
  
  var hour = DateTime.now().hour;
  if(hour < 12){
    return 'Good Morning,';
  }
   if(hour < 17){
    return 'Good Afternoon,';
  }
return 'Good Evening,';

}