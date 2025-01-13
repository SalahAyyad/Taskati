// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/utils/textstyle.dart';

class header2 extends StatelessWidget {
  const header2({
    super.key,
    required this.title,
    required this.subtitle,
    required this.customeWidget,
  });

  final String title;
  final String subtitle;
  final Widget customeWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text( title,
              
                style: getTiltleTextStyle(fontSize: 20),
              ),
            
             
          
            Text(
              subtitle,
              style: getBodyTextStyle(fontSize: 20),
            )
          ],
        ),
        Spacer(),
        customeWidget,
      ],
    );
  }
}
