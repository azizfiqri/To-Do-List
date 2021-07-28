import 'dart:async';

import 'package:flutter/material.dart';

class BackGroundPage extends StatefulWidget {
  const BackGroundPage({Key key}) : super(key: key);

  @override
  _BackGroundPageState createState() => _BackGroundPageState();
}

class _BackGroundPageState extends State<BackGroundPage> {
  var color = Colors.red;

  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 1500), (timer) {
      setState(() {
        color = color == Colors.red ? Colors.amber : Colors.red;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Container(
          color: color,
        ),
      ),
    );
  }
}
