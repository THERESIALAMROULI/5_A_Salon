import 'package:flutter/material.dart';
import 'package:tubesfix/View/login.dart';
import 'package:flutter/services.dart';
import 'package:tubesfix/View/transaction.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark
  ));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: transactionView(),
    );
  }
}