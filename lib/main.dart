import 'package:flutter/material.dart';
import 'package:tubesfix/View/login.dart';
import 'package:flutter/services.dart';
import 'package:tubesfix/View/transaction.dart';
import 'package:tubesfix/View/home.dart';
import 'View/login.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }    
}