import 'package:flutter/material.dart';

//This is a constant model designed for any text input for the app
InputDecoration textInputDecoration(String hintText) {
  return InputDecoration(
    //hint text is gonna be provided whenever is called
    hintText: hintText,
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    //focused border for when the user taps/clicks on the text box they know they are
    //interacting with it. Channges the color of the border to emphasize this action
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
  );
}
