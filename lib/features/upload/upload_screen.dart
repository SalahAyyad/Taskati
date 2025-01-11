// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/textstyle.dart';
import 'package:taskati/core/widgets/custome_button.dart';
import 'package:taskati/features/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  var nameController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async{
              if (formkey.currentState!.validate() &&  path!= null) {
                
                var userBox = Hive.box('user');
                userBox.put('name', nameController.text);
                userBox.put('image',path);
                userBox.put('isUploaded',true);
               pushTo(context, HomeScreen());
              } else if(path == null){

                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: Text("error",style: getSmallTextStyle()),
                    content: Text("please upload image"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("ok"))
                    ],
                  );

                });
              }
                
              }
            ,
            child: Text('Done', style: getSmallTextStyle(color: AppColor.whitecolor)),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: path != null
                    ? FileImage(File(path!))
                    : NetworkImage("https://picsum.photos/200"),
              ),
              SizedBox(height: 30),
              customeButton(
                text: 'Upload  from camera',
                onPressed: () async {
                  await ImagePicker()
                      .pickImage(source: ImageSource.camera)
                      .then(
                    (value) {
                      if (value != null) {
                        setState(() {
                          path = value.path;
                        });
                      }
                    },
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              customeButton(
                  text: 'Upload  from gallery',
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then(
                      (value) {
                        if (value != null) {
                          setState(() {
                            path = value.path;
                          });
                        }
                      },
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: AppColor.primaryColor,
                indent: 30,
                endIndent: 30,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: formkey,
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "name is required";
                      } else if (value.length<3) {
                        return "min is 3";
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "enter your name",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
