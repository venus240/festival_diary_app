import 'dart:io';

import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/fest.dart';
import 'package:festival_diary_app/services/fest_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDelFestUI extends StatefulWidget {
  Fest? fest;
  EditDelFestUI({super.key, this.fest});

  @override
  State<EditDelFestUI> createState() => _EditDelFestUIState();
}

class _EditDelFestUIState extends State<EditDelFestUI> {
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
  void initState() {
    festNameCTRL.text = widget.fest!.festName!;
    festDetailCTRL.text = widget.fest!.festDetail!;
    festStateCTRL.text = widget.fest!.festState!;
    festCostCTRL.text = widget.fest!.festCost!.toString();
    festNumDayCTRL.text = widget.fest!.festNumDay!.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          "ข้อมูล Festival Diary",
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
                  InkWell(
                    onTap: () async {
                      await openCamera();
                    },
                    child: festFile == null
                        ? widget.fest!.festImage! == ''
                            ? Image.asset(
                                'assets/images/festlogo.png',
                                width: 150,
                              )
                            : Image.network(
                                '$baseurl/images/fests/${widget.fest!.festImage!}',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
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
                          festCost: double.parse(festCostCTRL.text.trim()),
                          userId: widget.fest!.userId!,
                          festNumDay: int.parse(festNumDayCTRL.text.trim()),
                          festId: widget.fest!.festId,
                        );
                        if (await FestApi().updateFest(fest, festFile)) {
                          showCompleteSnackBar(
                              context, "บันทึกแก้ไขงาน Festivalสำเร็จ");
                          Navigator.pop(context);
                        } else {
                          showCompleteSnackBar(
                              context, "บันทึกแก้ไขงาน Festivalไม่สําเร็จ");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(mainColor),
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "บันทึกแก้ไข Festival",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (await FestApi().deleteFest(widget.fest!.festId!)) {
                        showCompleteSnackBar(context, 'ลบข้อมูลสำเร็จ');
                        Navigator.pop(context);
                      } else {
                        showWarningSnackBar(context, 'ลบข้อมูลไม่สําเร็จ');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "ลบงาน Festival",
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
