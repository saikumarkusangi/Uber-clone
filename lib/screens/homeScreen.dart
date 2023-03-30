import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import 'package:mapbox_gl_platform_interface/mapbox_gl_platform_interface.dart';
import 'package:uber_userside_clone/assistants/assistant_methods.dart';
import 'package:uber_userside_clone/authentication/signin_screen.dart';
import 'package:uber_userside_clone/global/global.dart';
import 'package:uber_userside_clone/screens/get_ride.dart';
import 'package:uber_userside_clone/screens/package.dart';
import 'package:uber_userside_clone/screens/splash_screen.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:uber_userside_clone/utils/demo_map.dart';
import '../global/global.dart';
import '../global/global.dart';
import '../helper/shared_preferences.dart';
import '../widgets/progessdialog.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  DateTime timeBackPressed = DateTime.now();

  String humanReadableAddress = 'Unable to detect current location!' ;
  @override
  void initState() {
    super.initState();
    AssistantMethods.readCurrentOnlineuserInfo();
     locateUserPosition();
     humanReadableAddress = getCurrentAddressFromSharedPrefs();
  }

   
  @override
  Widget build(BuildContext context) {
  
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          final msg = 'Press BACK again to EXIT.';
          Fluttertoast.showToast(msg: msg, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10),
            child: Image.asset('assets/images/title.png', width: 120),
          ),
        ),
        body: ColorfulSafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          children: [
                            Icon(Icons.location_pin),
                            (humanReadableAddress == 'Unable to detect current location!') ? 
                            Text(humanReadableAddress,
                            overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.black38,fontSize: 18)):
                                  Text(humanReadableAddress,
                            overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.indigo,fontSize: 18)),
                                
                          ],
                        ),
                      ),
                      InkWell(
                        onTap:(){locateUserPosition();},
                        child:
                       Padding(
                        padding: const EdgeInsets.only(left: 30,right: 10),
                        child:
                      (humanReadableAddress == 'Unable to detect current location!') ? 
                      
                      Text('Turn on Location', style: const TextStyle(color: Colors.blue,fontSize: 18,fontWeight:FontWeight.bold)):Text(''),),),
                    SizedBox(height: 20,) ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                      InkWell(
                        onTap: () {
                          Get.toNamed('/getRide');
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          height: MediaQuery.of(context).size.height / 3.5,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 228, 226, 226),
                              borderRadius: BorderRadius.circular(10)),
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/images/ubergo.png'),
                                    Text(
                                      'Get a ride',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.black,
                                      radius: 18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                       Navigator.push(context,MaterialPageRoute(builder: (c)=>PackageDelivery()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          height: MediaQuery.of(context).size.height / 3.5,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 228, 226, 226),
                              borderRadius: BorderRadius.circular(10)),
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Image.asset(
                                        'assets/images/package.png',
                                        width: 80,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Deliver Package',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.black,
                                      radius: 18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Favourite',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 50,
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.home,
                                size: 22,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.grey,
                              radius: 20,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 50,
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.work,
                                size: 22,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.grey,
                              radius: 20,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Work',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Around you',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Stack(children: [
                      Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          child: DemoMaps()),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DemoMaps())));
                        },
                        child: Container(
                          height: 200,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
