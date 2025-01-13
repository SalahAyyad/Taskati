// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';
import 'package:hive/hive.dart';
import 'package:taskati/core/widgets/profile_pic.dart';
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
         leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios,
            color: AppColor.whitecolor, size: 20)),
        title: Text(
          'My Profile',
          style: getTiltleTextStyle(color: AppColor.whitecolor, fontSize: 24),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children:[ Container(height: 200,width: 200,
                
                child: FittedBox(child: profilePic(path: path))),
               
            
              Positioned(
                top: 0,
                left:170,
                child: PopupMenuButton<String>(  onSelected: (value) async {
                 if (value == 'Option 1') {
                       await ImagePicker()
                        .pickImage(source: ImageSource.camera)
                        .then(
                      (value) {
                        if (value != null) {
                          setState(() {
                            path = value.path;
                            userBox.put("image", path);
                          });
                        }
                      },
                    );
                 } else if (value == 'Option 2') {   
                   await ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then(
                      (value) {
                        if (value != null) {
                          setState(() {
                            path = value.path;
                            userBox.put("image", path);
                          });
                        }
                      },
                    );

                  
                   
                 } else if (value == 'Option 3') {
                  await showDialog(context: context, builder: (context){
                     return AlertDialog(
                       title: Text("Change Name"),
                       content: TextField(
                         controller: TextEditingController(text: name),
                         onChanged: (value){
                           name = value;
                         },
                       ),
                       actions: [
                         TextButton(onPressed: () {

                           Navigator.pop(context);
                         }, child: Text("Cancel")),
                         TextButton(onPressed: () {
                           userBox.put("name", name);
                           Navigator.pop(context);
                         }, child: Text("Save"))
                       ]
                     );
                   });
                 } 
                }
                ,
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'Option 1',
                    child: Text('Change Profile Picture from camera'),
                  ),
                  PopupMenuItem(
                    value: 'Option 2',
                    child: Text('Change Profile Picture from gallery'),
                  ),
                  PopupMenuItem(
                    value: 'Option 3',
                    child: Text('Change Name'),
                  )
                            ] ),
              )]),
            ValueListenableBuilder(valueListenable: userBox.listenable(),
            builder: (context, Box box, _) {
              return Text(
                'you are awsome $name!',
                style: getTiltleTextStyle(),
              );
            },
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'View All Your ',
                  style: getBodyTextStyle(fontSize: 16),
                ),
                TextButton(
                  
                    onPressed: () {
                      pushTo(context, const CompletedTasks());
                    },
                    child: Text('Completed Tasks!',
                      
                      style: getBodyTextStyle(fontSize: 16,color: AppColor.greenColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
