// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';
import 'package:taskati/core/widgets/custome_button.dart';
import 'package:taskati/core/widgets/header.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:taskati/core/widgets/taskitem.dart';
import 'package:taskati/features/add_task.dart';
import 'package:taskati/features/profile_page.dart';

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
            customeWidget: GestureDetector(
              onTap: () {
                pushTo(context, ProfilePage());
              },
              child: CircleAvatar(
                radius: 45,
                backgroundImage: FileImage(File(path)),
              ),
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
              child: ValueListenableBuilder(
            valueListenable: Hive.box('task').listenable(),
            builder: (context, Box taskBox, child) {
              var tasks = taskBox.values.toList();

              return ListView.builder(
                itemCount: taskBox.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        tasks[index].isCompleted = true;
                      } else {
                        taskBox.deleteAt(index);
                      }
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.greenColor,
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Icon(Icons.check, color: AppColor.whitecolor),
                          SizedBox(width: 5),
                          Text(
                            'Completed',
                            style:
                                getSmallTextStyle(color: AppColor.whitecolor),
                          )
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.redColor,
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.delete, color: AppColor.whitecolor),
                          SizedBox(width: 5),
                          Text('Delete',
                              style: getSmallTextStyle(
                                  color: AppColor.whitecolor)),
                          SizedBox(width: 5)
                        ],
                      ),
                    ),
                    key: UniqueKey(),
                    child:taskItem(task: tasks[index]),
                  );
                },
              );
            },
          ))
        ],
      ),
    )));
  }
}
