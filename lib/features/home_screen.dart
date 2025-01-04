// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';
import 'package:taskati/core/widgets/custome_button.dart';
import 'package:taskati/core/widgets/header.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:taskati/features/add_task.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box("user");

    String name = userBox.get("name");
    String path = userBox.get("image");
    return Scaffold(
        //var userBox = Hive.box('user');
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          header(
            title: 'Hello ,$name',
            customeWidget: CircleAvatar(
              radius: 45,
              backgroundImage: FileImage(File(path)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          header(
            title: DateFormat("dd MMM yyyy").format(DateTime.now()),
            customeWidget: customeButton(
              width: 135,
              onPressed: () {
                pushTo(context, AddTask());

                
              },
              text: ' + Add Task',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColor.primaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                height: 65,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.primaryColor),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('flutter task 1',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getTiltleTextStyle(
                                color: AppColor.whitecolor, fontSize: 16)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: AppColor.whitecolor,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text('10:00 AM - 11:00 AM',
                                style: getTiltleTextStyle(
                                    color: AppColor.whitecolor, fontSize: 14))
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    VerticalDivider(
                      color: AppColor.whitecolor,
                      thickness: 3,
                      width: 10,
                    ),
                    RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'TODO',
                          style: getBodyTextStyle(
                              color: AppColor.whitecolor, fontSize: 16),
                        ))
                  ],
                ),
              );
            },
          ))
        ],
      ),
    )));
  }
}
