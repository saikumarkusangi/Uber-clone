import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:uber_userside_clone/authentication/signin_screen.dart';
import 'package:uber_userside_clone/mainScreen/mainScreen.dart';
import 'package:uber_userside_clone/screens/activityScreen.dart';
import 'package:uber_userside_clone/screens/get_ride.dart';
import 'package:uber_userside_clone/screens/homeScreen.dart';
import 'package:uber_userside_clone/screens/package.dart';
import 'package:uber_userside_clone/screens/profileScreen.dart';
import 'package:uber_userside_clone/screens/splash_screen.dart';
import 'package:uber_userside_clone/screens/userdata.dart';
import 'package:uber_userside_clone/utils/demo_map.dart';

import 'authentication/otp_screen.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';


 late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
           debugShowCheckedModeBanner: false,
      title: 'Uber',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/splashScreen',
          getPages: [
            GetPage(
        name: '/homeScreen',
        page: () => homeScreen(),
        transition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 1),
      ),
      GetPage(
        name: '/signinScreen',
        page: () => SignInScreen(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 1),
      ),
      GetPage(
        name: '/otpScreen',
        page: () => otpScreen(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 1),
      ),
      GetPage(
        name: '/profileScreen',
        page: () => ProfileScreen(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 1),
      ),
      GetPage(
        name: '/userScreen',
        page: () => UserData(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 1),
      ),
       GetPage(
        name: '/mainScreen',
        page: () => mainScreen(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 1),
      ),
       GetPage(
        name: '/activityScreen',
        page: () => ActivityScreen(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 1),
      ),
       GetPage(
        name: '/splashScreen',
        page: () => splashScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 1),
      ),
      GetPage(
        name: '/getRide',
        page: () => GetRide(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 2),
      ),
      GetPage(
        name: '/Package',
        page: () => PackageDelivery(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 2),
      ),
       GetPage(
        name: '/demoMap',
        page: () => DemoMaps(),
        transition: Transition.circularReveal,
        transitionDuration: Duration(milliseconds: 1),
      ),
          ],
          home: splashScreen()
    );
    

  }
}
