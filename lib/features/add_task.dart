// ignore_for_file: prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/model/task_adapter.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';
import 'package:taskati/core/widgets/custome_button.dart';
import 'package:taskati/features/home_screen.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController(
      text: DateFormat("dd/MM/yyyy ").format(DateTime.now()));
  var startTimeController = TextEditingController(
      text: DateFormat("hh :mm a").format(DateTime.now()));
  var endTimeController = TextEditingController(
      text: DateFormat("hh :mm a").format(DateTime.now()));

      TimeOfDay starttime = TimeOfDay.now();
      TimeOfDay endTime = TimeOfDay.now();




bool isBefore(TimeOfDay time1, TimeOfDay time2) {

 int minutes1 = time1.hour * 60 + time1.minute;

 int minutes2 = time2.hour * 60 + time2.minute;

 return minutes1 < minutes2;

}


  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios,
            color: AppColor.whitecolor, size: 20)),
        title: Text(
          'Add Task',
          style: getBodyTextStyle(color: AppColor.whitecolor, fontSize: 16),
        ),
        backgroundColor: AppColor.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
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
                    validator: (value) {
                      if (value != null) {
                        if (value.length < 5) {
                          return "title must be atleast 5 characters ";
                        }
                        return null;
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value != null) {
                        if (value.length < 5) {
                          return "notes must be atleast 10 characters ";
                        }
                        return null;
                      }
                      return null;
                    },
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
                              lastDate: DateTime(2026))
                          .then((value) {
                        if (value != null) {
                          dateController.text =
                              DateFormat("dd MMM yyyy").format(value);
                        }
                      });
                    },
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                      Icons.calendar_month,
                      color: AppColor.primaryColor,
                    )),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'start time',
                            style: getBodyTextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                if (value != null) {
                                  startTimeController.text =
                                      value.format(context);

                                     starttime = value;
                                }
                              });
                            },
                            controller: startTimeController,
                            readOnly: true,
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.access_time)),
                          )
                        ],
                      )),
                      SizedBox(width: 10),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'end time',
                            style: getBodyTextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime:  TimeOfDay.now())
                                  .then((value) {
                                if (value != null) {
                                  endTimeController.text =
                                      value.format(context);
                                      endTime = value;
                                }
                              });
                            },
                            controller: endTimeController,
                            readOnly: true,
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.access_time)),
                          )
                        ],
                      ))
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Row(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(2),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColor = index;
                                });
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: index == 0
                                    ? AppColor.primaryColor
                                    : index == 1
                                        ? AppColor.orangeColor
                                        : AppColor.redColor,
                                child: selectedColor == index
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          );
                        }),
                      ),
                      Spacer(),
                      customeButton(
                        text: 'create task',
                        onPressed: () {
                          print('$endTime , $starttime');
                          if (formKey.currentState!.validate()) {
                            

                            if (isBefore(endTime, starttime)) {
                              
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'start time comes before end time',
                                  style: TextStyle(color: Colors.white),
                                ),
                                duration: Duration(seconds: 3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                            else {
                              


                              TaskModel newtask = TaskModel(
                              id: DateTime.now().toString(),
                              title: titleController.text,
                              note: noteController.text,
                              date: dateController.text,
                              startTime: startTimeController.text,
                              endTime: endTimeController.text,
                              color: selectedColor,
                              isCompleted: false,
                            );
                            var taskbox = Hive.box<TaskModel>('task');
                           
                            taskbox.put(newtask.id, newtask);
                            pushWithReplacment(context, HomeScreen());
                            
                            }
                          }
                        }
                        
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
