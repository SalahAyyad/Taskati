import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';


TextStyle getTiltleTextStyle ({double? fontSize, Color? color, fontWeight}){
return TextStyle(
  fontSize: fontSize ?? 30,
  color: color ?? AppColor.primaryColor,
  fontWeight: FontWeight.bold,
);

}

TextStyle getBodyTextStyle ({double? fontSize, Color? color, fontWeight}){
return TextStyle(
  fontSize: fontSize ?? 24,
  color: color?? AppColor.greycolor,
  fontWeight: FontWeight.bold
);

}

TextStyle getSmallTextStyle ({double? fontSize, Color? color, fontWeight}){
return TextStyle(
  fontSize: fontSize ?? 16,
  color: color ?? AppColor.primaryColor,
  fontWeight: FontWeight.bold
);

}