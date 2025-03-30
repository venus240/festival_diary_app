import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/views/register_ui.dart';
import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          "Festival Diary",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
                    height: 40,
                  ),
                  Image.asset(
                    'assets/images/festlogo.png',
                    width: 200,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("ชื่อผู้ใช้"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
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
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(mainColor),
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("ยังไม่มีบัญชี?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterUI()));
                          },
                          child: Text(
                            "ลงทะเบียน",
                            style: TextStyle(color: Color(mainColor)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text("Copyright © 2025"),
                  Text("Created by Venus DTI-SAU"),
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
