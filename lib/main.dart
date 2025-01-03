// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taskati/features/into/splashScreen.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Splashscreen(),
        );
  }
}
