import 'package:evtp/UI/Screens/home.dart';
import 'package:evtp/main.dart';
import 'package:flutter/material.dart';

IconButton closeToMain(BuildContext context) {
  var closeButton = IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Home()));
      });
  return closeButton;
}

//Back

//Display
//card()
//column[]
//row[]
