import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp( FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  FitnessTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home:  HomeScreen(),
    );
  }
}