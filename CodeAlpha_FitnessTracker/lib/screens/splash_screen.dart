import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
          () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B10),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/logo.png',
              width: 230,
              height: 230,
              fit: BoxFit.contain,
            ),

             SizedBox(height: 25),
            const Text(
              'Fitness Tracker',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

             SizedBox(height: 10),

            const Text(
              'Track Your Progress • Stay Fit',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 40),

            const SizedBox(
              width: 190,
              child: LinearProgressIndicator(
                minHeight: 5,
                color: Color(0xFFB7FF3C),
                backgroundColor: Colors.white24,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Your fitness journey starts here',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}