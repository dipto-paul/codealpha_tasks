import 'package:flutter/material.dart';
import 'package:random_quote_generator/screens/home_screen.dart';
import 'package:random_quote_generator/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: SplashScreen(),
    );
  }
}
