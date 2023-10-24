import 'package:flutter/material.dart';
import 'package:test_flutter/page/home_page.dart';
import 'package:test_flutter/tools/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: title,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



