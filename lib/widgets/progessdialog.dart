import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProgressDialog extends StatelessWidget {
   ProgressDialog({super.key,required this.message});
  

  String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width/1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(children: [
               SizedBox(width: 20,),
              CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(width: 20,),
              Text(
                message,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18
                ),
              )
            ]),
          ),
        ),
    
    );
  }
}