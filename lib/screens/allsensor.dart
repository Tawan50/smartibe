import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartibe/src/ble/ble_device_connector.dart';
import 'package:smartibe/src/ble/ble_scanner.dart';
import 'package:provider/provider.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;
import 'dart:math';
import 'package:pedometer/pedometer.dart';
import 'package:smartibe/src/widgets.dart';
import 'dart:async';

import '../src/ui/device_detail/device_detail_screen.dart';

class AllSensor extends StatelessWidget {
  const AllSensor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer2<BleScanner, BleScannerState?>(
        builder: (_, bleScanner, bleScannerState, __) => _DeviceList(
          scannerState: bleScannerState ??
              const BleScannerState(
                discoveredDevices: [],
                scanIsInProgress: false,
              ),
          startScan: bleScanner.startScan,
          stopScan: bleScanner.stopScan,
        ),
      );
}

class _DeviceList extends StatefulWidget {
  const _DeviceList(
      {required this.scannerState,
      required this.startScan,
      required this.stopScan});

  final BleScannerState scannerState;
  final void Function(List<Uuid>) startScan;
  final VoidCallback stopScan;

  @override
  _SumTState createState() => _SumTState();
}

class _SumTState extends State<_DeviceList> {
  // bluetooth
  late TextEditingController _uuidController;
  late BleDeviceConnector _deviceController;

  // count step
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  int step = 0;
  int _steps_prev = 0;
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
    //bluetooth
    _uuidController = TextEditingController()
      ..addListener(() => setState(() {}));

    //count step
    initPlatformState();
    _fetchPermissionStatus();
  }

  //count step
  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() {
          _hasPermissions = (status == PermissionStatus.granted);
        });
      }
    });
  }

  //count step
  void initPlatformState() async {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final lastConnectedDeviceId = prefs.getString('last_connected_device_id');

    if (lastConnectedDeviceId != null) {
      //connect
      _deviceController.connect(lastConnectedDeviceId);
    }

    if (!mounted) return;
  }

  //count step
  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  //count step
  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  //count step
  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  //count step
  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
      step = event.steps;
    });
  }

  //bluetooth scan
  @override
  void dispose() {
    widget.stopScan();
    _uuidController.dispose();
    super.dispose();
  }

  //bluetooth
  bool _isValidUuidInput() {
    final uuidText = _uuidController.text;
    if (uuidText.isEmpty) {
      return true;
    } else {
      try {
        Uuid.parse(uuidText);
        return true;
      } on Exception {
        return false;
      }
    }
  }

  //bluetooth scan
  void _startScanning() {
    final text = _uuidController.text;
    widget.startScan(text.isEmpty ? [] : [Uuid.parse(_uuidController.text)]);
  }

  //bluetooth cal distance
  double calcDistance(int rssi) {
    return pow(10, ((-65 - (rssi)) / (10 * 3))).toDouble();
  }

  double rangeWarning = 25.0;

  List<String> products = List<String>.generate(5, (i) => "Product List: $i");

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
        ));
  }

  Widget _buildCompass() {
    final devices = widget.scannerState.discoveredDevices;

    return Align(
      alignment: Alignment.topRight,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Text(
            '',
            style: TextStyle(fontSize: 30),
          ),
          const Text(
            'Count Step:',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            _steps,
            style: const TextStyle(fontSize: 20),
          ),
          // Text(
          //   'current step : ' + step.toString(),
          //   style: const TextStyle(fontSize: 20),
          // ),
          // Text(
          //   'before walk  : ' + _steps_prev.toString(),
          //   style: const TextStyle(fontSize: 20),
          // ),
          const Text(
            'Pedestrian status:',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            _status == 'walking'
                ? 'walk'
                : _status == 'stopped'
                    ? 'stop'
                    : 'error',
            style: const TextStyle(fontSize: 20),
          ),
          Center(
            child: Text(
              _status,
              style: getStatus() == 'walking' || getStatus() == 'stopped'
                  ? const TextStyle(fontSize: 20)
                  : const TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
          const Divider(
            height: 50,
            thickness: 0,
            color: Colors.white,
          ),
          StreamBuilder<CompassEvent>(
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

              return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                const Text(
                  'Compass',
                  style: TextStyle(fontSize: 30),
                ),
                Center(
                  child: Text(
                    (direction * (math.pi / 180) * -1).toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ]);
            },
          ),
          const Divider(
            height: 50,
            thickness: 0,
            color: Colors.white,
          ),
          const Text(
            'Bluetooth',
            style: TextStyle(fontSize: 30),
          ),

          ElevatedButton(
            onPressed:
                !widget.scannerState.scanIsInProgress && _isValidUuidInput()
                    ? _startScanning
                    : null,
            child: const Text('Scan'),
          ),

          Flexible(
            child: ListView(
              children: widget.scannerState.discoveredDevices
                  .map(
                    (device) => ListTile(
                      title: Text(device.name),
                      subtitle: Text("${device.name}\n${device.id}\nRSSI:${device.rssi}"),
                      leading: const BluetoothIcon(),
                      onTap: () async {
                        widget.stopScan();

                        await Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DeviceDetailScreen(device: device)));
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

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

  String getTextName(List<DiscoveredDevice> d) {
    String text = '';
    for (var element in d) {
      if (element.name.toString() != '') {
        text = '$text${element.name} rssi:${element.rssi}\n';
      }
    }
    return text;
  }

  String getStatus() {
    if (_status == 'stopped') {
      _steps_prev = step;
    }
    return _status;
  }

  String setOnStartWalking() {
    return '';
  }
}
