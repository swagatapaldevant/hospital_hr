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
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, "/LogInTypeScreens");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hospital HR \n Application", textAlign: TextAlign.center,style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontSize: 28
        ),),
      ),
    );
  }
}
