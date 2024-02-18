import 'package:flutter/material.dart';
import 'package:smart_home_fe/pages/index_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IndexPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
