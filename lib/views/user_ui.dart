import 'dart:io';

import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/user.dart';
import 'package:festival_diary_app/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserUI extends StatefulWidget {
  User? user;
  UserUI({super.key, this.user});

  @override
  State<UserUI> createState() => _UserUIState();
}

class _UserUIState extends State<UserUI> {
  TextEditingController userFullNameCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

  bool isVisible = true;
  File? userFile;

  Future<void> openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;

    setState(() {
      userFile = File(image.path);
    });
  }

  showWarningSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }

  showCompleteSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
  }

  showUserInfo() async {
    setState(() {
      userFullNameCtrl.text = widget.user!.userFullname!;
      userNameCtrl.text = widget.user!.userName!;
      userPasswordCtrl.text = widget.user!.userPassword!;
    });
  }

  @override
  void initState() {
    showUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          "ข้อมูลส่วนตัว",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "ลงทะเบียน",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      await openCamera();
                    },
                    child: userFile == null
                        ? widget.user!.userImage != ''
                            ? Image.network(
                                '$baseurl/images/users/${widget.user!.userImage!}',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.person_add,
                                size: 100,
                                color: Color(mainColor),
                              )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              userFile!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("ชื่อ-นามสกุล"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: userFullNameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.featured_play_list),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("ชื่อผู้ใช้"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: userNameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("รหัสผ่าน"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: userPasswordCtrl,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (userFullNameCtrl.text.trim().isEmpty) {
                        showWarningSnackBar(context, "กรุณากรอกชื่อ-นามสกุล");
                      } else if (userNameCtrl.text.trim().isEmpty) {
                        showWarningSnackBar(context, "กรุณากรอกชื่อผู้ใช้");
                      } else if (userPasswordCtrl.text.trim().isEmpty) {
                        showWarningSnackBar(context, "กรุณากรอกรหัสผ่าน");
                      } else {
                        User user = User(
                          userId: widget.user!.userId,
                          userFullname: userFullNameCtrl.text.trim(),
                          userName: userNameCtrl.text.trim(),
                          userPassword: userPasswordCtrl.text.trim(),
                        );
                        user = await UserApi().updateUser(user, userFile);
                        if (user.userId != null) {
                          showCompleteSnackBar(context, "แก้ไขเรียบร้อยแล้ว");
                          Navigator.pop(context, user);
                        } else {
                          showCompleteSnackBar(context, "แก้ไขไม่สําเร็จ");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(mainColor),
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "บันทึกแก้ไขข้อมูลส่วนตัว",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Copyright © 2025"),
                  Text("Created by Chanachai DTI-SAU"),
                  SizedBox(
                    height: 20,
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
