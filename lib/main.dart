import 'package:festival_diary_app/views/splash_screen_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FestivalDiaryApp());
}

class FestivalDiaryApp extends StatefulWidget {
  const FestivalDiaryApp({super.key});

  @override
  State<FestivalDiaryApp> createState() => _FestivalDiState();
}

class _FestivalDiState extends State<FestivalDiaryApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
    );
  }
}
