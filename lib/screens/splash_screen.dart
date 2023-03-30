import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:uber_userside_clone/assistants/assistant_methods.dart';
import 'package:uber_userside_clone/authentication/signin_screen.dart';
import 'package:uber_userside_clone/mainScreen/mainScreen.dart';
import 'package:uber_userside_clone/screens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global.dart';
import '../helper/map_handler.dart';
import '../main.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  startTimer(){
  
  
   
    Future.delayed(Duration(seconds: 3), () async {
     
    });
   
  }
  
  @override
  void initState() { 
    super.initState();
    locateUserPosition();
    initializeLocationAndSave();
     sharedPreferences.setString('currentaddress', 'Unable to detect current location!');
  }
   void initializeLocationAndSave() async {
   
    Future.delayed(Duration(seconds: 3), (() async {
      fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineuserInfo() : null;
     if (await fAuth.currentUser != null ) {
      currentFirebaseUser = fAuth.currentUser;
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const mainScreen()), (route) => false);
      
    }
    else{
        Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const SignInScreen()), (route) => false);
    }

    }));

    
    
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: Image.asset('assets/images/gif.gif'),
      ),
    );
  }
}