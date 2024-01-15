import 'package:flutter/material.dart';
import 'View/splashscreen.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplahScreen(),

      debugShowCheckedModeBanner: false,
    );
  }
}
