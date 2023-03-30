import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:uber_userside_clone/authentication/signin_screen.dart';
import 'package:uber_userside_clone/screens/homeScreen.dart';

import '../global/global.dart';

/// This is the basic usage of Pinput
/// For more examples check out the demo directory
class otpScreen extends StatefulWidget {
  const otpScreen({Key? key}) : super(key: key);

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  var code = '';
  bool _loading = false;
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Scaffold(
       resizeToAvoidBottomInset : true,
      body: SingleChildScrollView(
        child: Column(
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
                'Enter otp to continue',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50,),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Directionality(
                    
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Pinput(
                        length: 6,
                        controller: pinController,
                        focusNode: focusNode,
                        // androidSmsAutofillMethod:
                        //     AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        // defaultPinTheme: defaultPinTheme,
                        // validator: (value) {
                        //   return value == '2222' ? null : 'Pin is incorrect';
                        // },
                        // onClipboardFound: (value) {
                        //   debugPrint('onClipboardFound: $value');
                        //   pinController.setText(value);
                        // },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          code = value;
                          
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                   Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: ElevatedButton(
                  
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: ()  async {
                      try {
                        setState(() {
                          _loading = true;
                        });
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: SignInScreen.verify,
                         smsCode: code
                         
                         );
                         await auth.signInWithCredential(credential);
                            userRef.child(fAuth.currentUser!.uid).once().then((userKey) {
                           final snap = userKey.snapshot;
                           if(snap.value != null){
                                   Get.toNamed('/mainScreen');
                                      }else{
                               Get.offAndToNamed('/userScreen');
                                      }
                                   });
                        
                         
                      
                      } catch (e) {
                        Fluttertoast.showToast(
            msg:e.toString()
           );
                      }
                     
                      
              },
                    child: 
                     
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child:  Center(
                          child:(_loading == false)? Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ) : CircularProgressIndicator(color: Colors.white,)
                        ),
                      ),
                    ),
              ),
              SizedBox(height: 20,),
              Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                children: [
              
                  Text(
                            "Don't received the code ? ",
                            style: TextStyle(
                                color: Colors.black87,
                                
                                fontSize: 18),
                          ),
                            InkWell(
                              onTap: (){
                                SignIn();
                              },
                              child: Text(
                              "Resend again",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                                                      ),
                            ),
                ],
              )
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}