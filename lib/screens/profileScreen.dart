import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uber_userside_clone/assistants/assistant_methods.dart';

import '../global/global.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 219, 216, 216),
                        radius: 40,
                        child: Icon(Icons.person,size: 60,color: Color.fromARGB(255, 122, 121, 121),),
                      ),
                    SizedBox(width: 20,),
                    Expanded(child:
                     Text(userModelCurrentInfo!.name.toString(),
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 42),)
                    ),
                   
                  
                  ],
                ),
                
                SizedBox(height: 10,),
                Divider(color: Colors.grey,),
                 SizedBox(height: 10,),
                 InkWell(
                 
                  child: Container(
                    height: 80,
                    child: Row(
                     
                      children: [
                        Icon(Icons.phone,size: 30,color: Colors.black,),
                        SizedBox(width: 20,),
                        Text(userModelCurrentInfo!.mobile.toString(),style: TextStyle(fontSize: 22),),
                       Spacer(),
                        InkWell(
                          onTap: (() {
                            
                          }),
                          child: Icon(Icons.mode_edit,size: 30,color: Colors.black38,)),
                      ],
                    ),
                  ),
                ),
                 InkWell(
                 
                  child: Container(
                    height: 80,
                    child: Row(
                      
                      children: [
                        Icon(Icons.location_on,size: 30,color: Colors.black,),
                        SizedBox(width: 20,),
                        Expanded(
                          flex: 2,
                          child: Text(userModelCurrentInfo!.address.toString(),style: TextStyle(fontSize: 22),)),
                        Spacer(),
                         InkWell(
                          onTap: (() {
                            
                          }),
                          child: Icon(Icons.mode_edit,size: 30,color: Colors.black38,)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    height: 80,
                    child: Row(
                      
                      children: [
                        Icon(Icons.help,size: 30,color: Colors.black,),
                        SizedBox(width: 20,),
                        Text('Help',style: TextStyle(fontSize: 22),)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    height: 80,
                    child: Row(
                      
                      children: [
                        Icon(Icons.info,size: 30,color: Colors.black,),
                        SizedBox(width: 20,),
                        Text('About Developer',style: TextStyle(fontSize: 22),)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    
                       await user!.delete();
                         FirebaseDatabase.instance.ref().child('users').child(user!.uid).remove();
                        Get.toNamed('/signinScreen');
                     
                   
                  },
                  child: Container(
                    height: 80,
                    child: Row(
                      
                      children: [
                        Icon(Icons.delete_forever,size: 30,color: Colors.black,),
                        SizedBox(width: 20,),
                        Expanded(child: Text('Delete Account Permanently',style: TextStyle(fontSize: 22),))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap:  (() => signOut()),
                  child: Container(
                    height: 80,
                    child: Row(
                      
                      children: [
                        Icon(Icons.logout_outlined,size: 30,color: Colors.black,),
                        SizedBox(width: 20,),
                        Text('Sign Out',style: TextStyle(fontSize: 22),)
                      ],
                    ),
                  ),
                ),
                 
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}