// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController(
      text: DateFormat("dd/MM/yyyy ").format(DateTime.now()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: getBodyTextStyle(color: AppColor.whitecolor, fontSize: 16),
        ),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: getBodyTextStyle(),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: titleController,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Note',
              style: getBodyTextStyle(),
            ),
            TextFormField(
              controller: noteController,
              maxLines: 4,
            ),
            SizedBox(height: 10),
            Text(
              'Date',
              style: getBodyTextStyle(),
            ),
            TextFormField(
              onTap: () {
                showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(2026)).then((value){

                      if (value!=null){
                        dateController.text = DateFormat("dd/MM/yyyy ").format(value);
                      }
                    });},
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                Icons.calendar_month,
                color: AppColor.primaryColor,
              )),
            )
          ],
        ),
      )),
    );
  }
}
