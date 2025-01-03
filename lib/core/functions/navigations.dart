import 'package:flutter/material.dart';

pushTo (BuildContext context ,Widget newScreen){
Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return newScreen;


        }));
}

pushWithReplacment (BuildContext context ,Widget newScreen){
Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return newScreen;


        }));
}