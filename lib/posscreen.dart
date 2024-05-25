import 'package:flutter/material.dart';
import 'package:smartibe/screens/LoginScreen.dart';
import 'package:smartibe/screens/registerscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

class PosScreen extends StatefulWidget {
  const PosScreen({Key? key}) : super(key: key);

  @override
  State<PosScreen> createState() => _PositionScreenState();
}

class _PositionScreenState extends State<PosScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Column(
            mainAxisSize: MainAxisSize.max,
          children: [
              Container(
                width: 1000,
                height: 710,
                child: Stack(
                  children: [
                   Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Image.asset(
                        'assets/positionxy.jpg',
                        width: 400,
                        height: 920,
                        fit: BoxFit.cover,
                      ),
                    ),  
                    const Align(
                      alignment: AlignmentDirectional(0.1, -0.35),
                      child: Text('5 m',),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
