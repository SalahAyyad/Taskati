// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';

class profilePic extends StatelessWidget {
  const profilePic({
    super.key,
    required this.path,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 45,
      backgroundImage: FileImage(File(path)),
    );
  }
}
