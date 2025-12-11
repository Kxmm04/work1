import 'package:flutter/material.dart';
import 'package:work1/pagemain.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:PageMain(),
    );
  }
} 