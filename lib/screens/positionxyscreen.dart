import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

import 'package:pedometer/pedometer.dart';
import 'dart:async';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

void main() {
  runApp(PositionxyScreen());
}

class PositionxyScreen extends StatefulWidget {
  @override
  State<PositionxyScreen> createState() => _PositionxyScreenState();
}

class _PositionxyScreenState extends State<PositionxyScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  bool _hasPermissions = false;
  double organ = 0.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _fetchPermissionStatus();
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() {
          _hasPermissions = (status == PermissionStatus.granted);
        });
      }
    });
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Builder(
            
            builder: (context) { 
              if (_hasPermissions) {
                return _buildCompass();
              } else {
                return _buildPermissionSheet();
              }
             
            },
         
        ),
        )
        );
  }

  //compass widget
  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        //error msg
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, thendevice does nit support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text('Device does not have sensors'),
          );
        }
organ = direction* (math.pi / 180) * -1;
// return compass
        return Center(
          child: Transform.rotate(
            angle: (direction * (math.pi / 180) * -1),
            child: Image.asset(
              'assets/compass.png',
              color: Color.fromARGB(255, 214, 64, 64),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  //permission sheet widget
  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text('Request Permission'),
        onPressed: () {
          Permission.locationWhenInUse.request().then((value) {
            _fetchPermissionStatus();
          });
        },
      ),
    );
  }
  Widget StepCount2() {
    return Center(
      child: Column(
        children: <Widget>[
      Text(
                'Steps taken:',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                _steps,
                style: TextStyle(fontSize: 60),
              ),
        ]
      ),
    );
  }
}
