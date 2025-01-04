// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:taskati/core/utils/textstyle.dart';

class header extends StatelessWidget {
  const header({
    super.key,
    required this.title,
    required this.customeWidget,
  });

  final String title;
  
  final Widget customeWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getTiltleTextStyle(fontSize: 16),
            ),
            Text(
              'Have a nice day! ',
              style: getBodyTextStyle(),
            )
          ],
        ),
        Spacer(),
        customeWidget,
      ],
    );
  }
}
