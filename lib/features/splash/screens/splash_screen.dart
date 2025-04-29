import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Simulate some loading time
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, "/AdminLogInScreens");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hospital HR \n Application", textAlign: TextAlign.center,style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontSize: 28,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
