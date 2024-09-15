import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/home_page.dart'; // HomePage import

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000, // Duration of splash screen (3 seconds)
      splash: const Text(
        'Shopping App',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      nextScreen: const HomePage(), // Navigate to HomePage
      splashTransition: SplashTransition.fadeTransition, // Choose transition
      backgroundColor: Colors.blue, // Set background color for splash
      splashIconSize: 150, // Size of the splash widget
    );
  }
}

