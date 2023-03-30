import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_userside_clone/authentication/otp_screen.dart';
import 'package:uber_userside_clone/global/global.dart';
import 'package:uber_userside_clone/mainScreen/mainScreen.dart';
import 'package:uber_userside_clone/screens/homeScreen.dart';
import '../screens/userdata.dart';
import '../utils/textField.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static String verify = '';
 
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
 
 
 bool _Loading = false;

@override


// Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.



  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
      stream: fAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return mainScreen();
        }else{
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
             ClipRRect(
              
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),bottomRight: Radius.circular(0)),
        child: Image.asset('assets/images/cover.jpg',
           fit: BoxFit.cover,
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height/1.8,
        ),),
         
    
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Sign up to book a ride',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      
                       Container(
                        height: 55,
                         child: TextField(
                          keyboardType: TextInputType.phone,
                          cursorColor: Colors.black,
                          style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2),),
                   hintText: 'Enter mobile number',
                   
                   hintStyle: TextStyle(fontSize: 22)
                     ),
                     onChanged: ((value) {
                       mobilenumber = value;
                     }),
                     ),
                       ),
                     
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: ElevatedButton(
                    
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: ()  async {
                        setState(() {
                          _Loading =true;
                        });
                       SignIn();
                },
                      child: 
                       
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Center(
                            child: (_Loading == false)? Text(
                              'Continue',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ): CircularProgressIndicator(color: Colors.white,)
                          ),
                        ),
                      ),
                ),
               
                 SizedBox(height: 10,),
                Text('OR',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18,),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: ElevatedButton(
                    
                     style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 201, 198, 198),
                      ),
                    onPressed: 
                      () async {
             
              FirebaseService service = new FirebaseService();
              try {
               await service.signInwithGoogle();
               currentFirebaseUser = fAuth.currentUser;
                 
              } catch(e){
                if(e is FirebaseAuthException){
                  Fluttertoast.showToast(msg: e.message!);
                }
              }
             
                      },
                    
                     child:  Container(
                        width: MediaQuery.of(context).size.width,
                          height: 50,
                       child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/google.png',width: 30,),
                              Center(child: Text('Continue with Google',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 18),))
                            
                            ],
                          ),
                     ),
                     ),
                 
                )
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "Don't have an accont? ",
                //         style: TextStyle(fontSize: 16),
                //       ),
                //       InkWell(
                //           onTap: () {
                //             // Navigator.push(
                //             //     context,
                //             //     MaterialPageRoute(
                //             //         builder: (_) => SignupScreen()));
                //           },
                //           child: Text(
                //             'Sign Up',
                //             style: TextStyle(
                //                 fontSize: 18, fontWeight: FontWeight.bold),
                //           )),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        );
      }
  });
  }
}

