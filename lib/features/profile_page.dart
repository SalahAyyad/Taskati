import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';
import 'package:hive/hive.dart';
import 'package:taskati/features/completed_tasks.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box("user");
    String name = userBox.get("name");
    String path = userBox.get("image");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: getTiltleTextStyle(color: AppColor.whitecolor, fontSize: 24),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: FileImage(
                File(path),
              ),
            ),
            Text(
              'you are awsome $name!',
              style: getTiltleTextStyle(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'you have completed ',
                  style: getBodyTextStyle(fontSize: 16),
                ),
                TextButton(
                  
                    onPressed: () {
                      pushTo(context, const CompletedTasks());
                    },
                    child: Text(
                      'this many tasks',
                      style: getBodyTextStyle(fontSize: 16),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
