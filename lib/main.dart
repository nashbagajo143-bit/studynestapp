import 'package:flutter/material.dart';
import 'landing_page.dart';

void main() {
  runApp(StudyNestApp());
}

class StudyNestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyNest',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: LandingPage(),
    );
  }
}
