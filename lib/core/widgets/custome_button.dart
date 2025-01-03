// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';

class customeButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? bgColor;
  final Color? textColor;
  final String text;
  final Function() onPressed;
  const customeButton({
    super.key,
    this.width= 250,
    this.height = 45,
    required this.text,
    this.bgColor,
    this.textColor,
    required this.onPressed
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    width: width,
    height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: getSmallTextStyle(color: textColor??  AppColor.whitecolor),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor?? AppColor.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          )),
    );
  }
}
