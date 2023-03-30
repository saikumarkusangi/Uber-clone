import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFields extends StatelessWidget {
 TextFields({required this.controller,required this.label,required this.type,required this.icons,required this.ispass,required this.icon});
  TextEditingController? controller;
  String? label;
  TextInputType? type;
  bool ispass;
  Widget? icon;
  Widget? icons;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 18),
      cursorColor: Colors.black,
      controller: controller,
      keyboardType: type,
      obscureText: ispass,
      decoration: InputDecoration(
        label: Text(label!),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
        
          borderSide: BorderSide(color: Colors.black)
        ),
        hintStyle: TextStyle(color: Colors.grey,fontSize: 10),
        suffixIcon: icon,
        icon: icons,
        
        iconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        labelStyle: TextStyle(color: Colors.grey),
        floatingLabelStyle: TextStyle(color: Colors.black),
      
      ),
    );
  }
}