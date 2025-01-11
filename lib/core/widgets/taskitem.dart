// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';

class taskItem extends StatelessWidget {

  final TaskModel task;
  const taskItem({
    super.key,
    required this.task,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10,left: 5,right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: task.color == 0? AppColor.primaryColor 
          : task.color == 1 ? AppColor.orangeColor
          : AppColor.redColor),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getTiltleTextStyle(
                      color: AppColor.whitecolor, fontSize: 16)),
                      SizedBox(width: 5),
                  Text(task.note,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                      style: getTiltleTextStyle(
                          color: AppColor.whitecolor, fontSize: 14)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: AppColor.whitecolor,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Text("${task.startTime} : ${task.endTime}",
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
  }
}
