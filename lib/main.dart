import 'package:flutter/material.dart';
import 'package:tubesfix/View/home_view.dart';

import 'View/login.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }    
}