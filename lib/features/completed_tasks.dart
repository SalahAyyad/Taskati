import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';
import 'package:taskati/core/widgets/taskitem.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios,
            color: AppColor.whitecolor, size: 20)),
        title: Text(
          'Completed tasks',
          style: getTiltleTextStyle(
            color: AppColor.whitecolor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: Hive.box<TaskModel>('completed_tasks').listenable(),
            builder: (context, Box taskBox, child) {
              var tasks = taskBox.values.toList();
              
              return ListView.builder(
                itemCount: taskBox.length,
                itemBuilder: (context, index) {
                  if (tasks[index].isCompleted == true) {
                    return taskItem(task: tasks[index], );
                  }
                  return null;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
