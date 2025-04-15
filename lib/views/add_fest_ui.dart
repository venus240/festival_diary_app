import 'dart:io';

import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/fest.dart';
import 'package:festival_diary_app/services/fest_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFestUI extends StatefulWidget {
  int? userId;
  AddFestUI({super.key, this.userId});

  @override
  State<AddFestUI> createState() => _AddFestUIState();
}

class _AddFestUIState extends State<AddFestUI> {
  File? festFile;

  TextEditingController festNameCTRL = TextEditingController();
  TextEditingController festDetailCTRL = TextEditingController();
  TextEditingController festStateCTRL = TextEditingController();
  TextEditingController festCostCTRL = TextEditingController();
  TextEditingController festNumDayCTRL = TextEditingController();
  Future<void> openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;

    setState(() {
      festFile = File(image.path);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          "เพิ่ม Festival Diary",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
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
                    "เพิ่มข้อมูล Festival",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      await openCamera();
                    },
                    child: festFile == null
                        ? Icon(
                            Icons.travel_explore,
                            size: 100,
                            color: Color(mainColor),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              festFile!,
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
                    child: Text("ชื่องาน Fest"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: festNameCTRL,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.festival),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("รายละเอียดงาน Festival"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: festDetailCTRL,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.details_outlined),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("สถานที่จัดงาน Festival"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: festStateCTRL,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_clock),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("ค่าใช้จ่ายงาน Festival"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: festCostCTRL,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.money_off),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("ไปงาน Festival กี่วัน"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: festNumDayCTRL,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timelapse),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (festNameCTRL.text.trim().isEmpty) {
                        showWarningSnackBar(context, "กรุณากรอกชื่องาน Fest");
                      } else if (festDetailCTRL.text.trim().isEmpty) {
                        showWarningSnackBar(
                            context, "กรุณากรอกรายละเอียด FEstival");
                      } else if (festStateCTRL.text.trim().isEmpty) {
                        showWarningSnackBar(
                            context, "กรุณากรอกสถานที่จัดงาน Festival");
                      } else if (festCostCTRL.text.trim().isEmpty) {
                        showWarningSnackBar(
                            context, "กรุณากรอกค่าใช้จ่ายงาน Festival");
                      } else if (festNumDayCTRL.text.trim().isEmpty) {
                        showWarningSnackBar(
                            context, "กรุณากรอกไปงาน Festival กี่วัน");
                      } else {
                        Fest fest = Fest(
                          festName: festNameCTRL.text.trim(),
                          festDetail: festDetailCTRL.text.trim(),
                          festState: festStateCTRL.text.trim(),
                          festCost: int.parse(festCostCTRL.text.trim()),
                          userId: widget.userId,
                          festNumDay: int.parse(festNumDayCTRL.text.trim()),
                        );
                        if (await FestApi().addFest(fest, festFile)) {
                          showCompleteSnackBar(
                              context, "บันทึกงาน Festivalสำเร็จ");
                          Navigator.pop(context);
                        } else {
                          showCompleteSnackBar(
                              context, "บันทึกงาน Festivalไม่สําเร็จ");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(mainColor),
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "บันทึกงาน Festival",
                      style: TextStyle(color: Colors.white),
                    ),
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
