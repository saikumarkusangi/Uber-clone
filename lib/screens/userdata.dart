import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uber_userside_clone/screens/homeScreen.dart';
import 'package:uber_userside_clone/global/global.dart';
import '../global/global.dart';
import '../utils/textField.dart';
import '../widgets/progessdialog.dart';


class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  TextEditingController  nameTextEditingController = TextEditingController();
  TextEditingController  placeTextEditingController = TextEditingController();
  TextEditingController  mobileTextEditingController = TextEditingController();
 
   SaveInfo()async{
   showDialog(context: context,
    barrierDismissible: false,
     builder: (BuildContext c){
      return ProgressDialog(
        message: 'Saving, please wait...',
      );
     });
     
     if(fAuth.currentUser!.uid.isNotEmpty)
     {
       
   
       
       userRef.child(fAuth.currentUser!.uid).set(
        {
          'id':fAuth.currentUser!.uid,
          'name':nameTextEditingController.text.trim(),
          'mobile':mobileTextEditingController.text.trim(),
          'address':placeTextEditingController.text.trim()
        }
       );
        Fluttertoast.showToast(
            msg:'Account has been Created🎉🎉.'
           );
          Get.offAllNamed('/mainScreen');
     }
     else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Account has not been Created⚠️⚠️.');
     }
 }
  @override
  Widget build(BuildContext context) {
    bool ispassw = true;
   
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: 
         SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            
               ClipRRect(
          
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),bottomRight: Radius.circular(0)),
    child: Image.asset('assets/images/cover.jpg',
       fit: BoxFit.cover,
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height/2,
    ),),
                     SizedBox(
                height:10,
              ),
                     Text('Upload Profile',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),),
                  
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                   
                    TextFields(
                      controller: nameTextEditingController,
                    label: 'Name',
                      type: TextInputType.name,
                      ispass: false,
                      icon:null,
                      icons: Icon(Icons.person,color: Colors.grey,),
                     ),
                  
                     TextFields(
                      controller: mobileTextEditingController,
                      label: 'Mobile Number',
                        icons: Icon(Icons.phone,color: Colors.grey,),
                       type: TextInputType.number,
                       ispass: false,
                        icon:null
                     ) ,
                   
                     TextFields(
                      controller: placeTextEditingController,
                      label: 'City',
                        icons: Icon(Icons.location_on,color: Colors.grey,),
                       type: TextInputType.name,
                       ispass: false,
                        icon:null
                     ) ,
                     SizedBox(height: 20,),
                       Text('By proceeding. I agree to Ubers Terms of Use and acknowledge that i have read the Privacy Policy.',style: TextStyle(fontSize: 14),),                               
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  
                ),
                onPressed: (){
            SaveInfo();
                   
              }, 
              child: Text('Save & Book a ride',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
              ),
            
            ],
          ),
        ),
    
    );
  }
}