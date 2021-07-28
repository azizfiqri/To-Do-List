import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_keeper_getx/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Get.off(HomeScreen());
      // transition: Transition.rightToLeft,
      // duration: Duration(seconds: 2),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_sharp,
              size: 100.0,
            ),
            Text(
              "To Do List",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
