import 'package:flutter/material.dart';
// import 'View/login.dart';
import 'View/profile.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: profileView(),
    );
  }
}
