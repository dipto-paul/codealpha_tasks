import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../utils/asset_url.dart';

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
      Duration(seconds: 3), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16002B),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetUrl.logo, width: 200, height: 200,
            ),

            SizedBox(height: 25),
            const Text(
              "Flashcard Quiz",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

             SizedBox(height: 8),
            const Text(
              "Learn • Remember • Grow",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),

            SizedBox(height: 35),

            const SizedBox(
              width: 180,
              child: LinearProgressIndicator(
                minHeight: 5,
                color: Colors.amber,
                backgroundColor: Colors.white24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}