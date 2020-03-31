import 'package:flutter/material.dart';

class Input extends StatelessWidget{
  final label, keyboard, controller, validator, onSaved;
  Input({this.label, this.keyboard, this.controller, 
  this.validator, this.onSaved});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: keyboard,
        controller: controller,
        validator: (w)=> validator(w),
        onSaved: (w)=> onSaved(w),
        decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(15),
          // ),
          // contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
          labelText: label,
          labelStyle: TextStyle( fontSize: 14),
          
        ),
        
      ),
    );
  }

}