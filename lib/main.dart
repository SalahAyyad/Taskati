// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/features/into/splash_screen.dart';


void main() async {
  
  WidgetsFlutterBinding();
  await Hive.initFlutter();
  await Hive.openBox('user');
  runApp( MainApp());
}

class MainApp extends StatelessWidget  {
  
   const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primaryColor

        ),
        inputDecorationTheme: InputDecorationTheme(enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),



     
      home: Splashscreen(),
        );
  }
}
