// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/functions/navigations.dart';

import 'package:taskati/core/utils/textstyle.dart';
import 'package:taskati/features/upload/upload_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      pushWithReplacment(context, UploadScreen());
       } );
      
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('./assets/images/tasklogo.json')
            ,Text('Taskati',style: getTiltleTextStyle(),), Text("it's time to get organized",style: getBodyTextStyle(),)],
        ),
      ),
    );
  }
}
