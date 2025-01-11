// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/model/task_adapter.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';
import 'package:taskati/core/widgets/custome_button.dart';
import 'package:taskati/core/widgets/header.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:taskati/core/widgets/taskitem.dart';
import 'package:taskati/features/add_task.dart';
import 'package:taskati/features/profile_page.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ValueNotifier<String> datePicked;

  @override
  void initState() {
    super.initState();
    datePicked = ValueNotifier<String>(DateFormat("dd MMM yyyy").format(DateTime.now()));
  }

  @override
  void dispose() {
    datePicked.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box("user");
    String name = userBox.get("name");
    String path = userBox.get("image");

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              header(
                title: 'Hello, $name',
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
                      datePicked.value = DateFormat("dd MMM yyyy").format(date);
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: datePicked,
                  builder: (context, String selectedDate, child) {
                    return ValueListenableBuilder(
                      valueListenable: Hive.box<TaskModel>('task').listenable(),
                      builder: (context, Box<TaskModel> taskBox, child) {
                        var tasks = taskBox.values
                            .where((element) => element.date == selectedDate)
                            .toList();

                        return ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            var task = tasks[index];

                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  var newTask = TaskModel(
                                    id: DateTime.now().toString(),
                                    title: task.title,
                                    note: task.note,
                                    date: task.date,
                                    startTime: task.startTime,
                                    endTime: task.endTime,
                                    color: 3,
                                    isCompleted: true,
                                  );

                                  taskBox.delete(task);

                                  Hive.box<TaskModel>('completed_tasks')
                                      .put(newTask.id, newTask);
                                } else {
                                  taskBox.delete(task);
                                }
                              },
                              background: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.greenColor,
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Icon(Icons.check,
                                        color: AppColor.whitecolor),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Completed',
                                      style: getSmallTextStyle(
                                          color: AppColor.whitecolor),
                                    ),
                                  ],
                                ),
                              ),
                              secondaryBackground: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.redColor,
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.delete,
                                        color: AppColor.whitecolor),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Delete',
                                      style: getSmallTextStyle(
                                          color: AppColor.whitecolor),
                                    ),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              child: taskItem(task: task),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
