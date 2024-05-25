import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:smartibe/src/ble/ble_scanner.dart';
import 'package:provider/provider.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;
import 'src/widgets.dart';
import 'src/ui/device_detail/device_detail_screen.dart';
import 'dart:math';
import 'package:pedometer/pedometer.dart';
import 'dart:async';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class DeviceListScreenBT extends StatelessWidget {
  const DeviceListScreenBT({Key? key}) : super(key: key);

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
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<_DeviceList> {
  late TextEditingController _uuidController;
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  bool _hasPermissions = false;
  double organ = 0.0;
  @override
  void initState() {
    super.initState();
    initPlatformState();
    _uuidController = TextEditingController()
      ..addListener(() => setState(() {}));
    _startScanning();
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
  void dispose() {
    widget.stopScan();
    _uuidController.dispose();
    super.dispose();
  }

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

  void _startScanning() {
    final text = _uuidController.text;
    widget.startScan(text.isEmpty ? [] : [Uuid.parse(_uuidController.text)]);
  }

  double calcDistance(int rssi) {
    return pow(10, ((-65 - (rssi)) / (10 * 3))).toDouble();
  }

  String distance_s = '';
  String namefiltter = 'LifeSmart Tag';
  double rangeWarning = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Image.asset(
                    'assets/poshead.png',
                    width: 400,
                    fit: BoxFit.cover,
                  )),
              const Text('Device name'),
                Text(organ.toString()),
 Scaffold(
          body: Builder(
            
            builder: (context) { 
              if (_hasPermissions) {
                return _buildCompass();
              } else {
                return _buildPermissionSheet();
              }
             
            },
            
          ),
        
        ),
        
              TextField(
                controller: TextEditingController()..text = namefiltter,
                enabled: true,
                textAlign: TextAlign.center,
                onChanged: (text) {
                  print('First text field: $text');
                  namefiltter = text;
                },
              ),
              Container(
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: (widget.scannerState.discoveredDevices
                                  .where((element) =>
                                      element.name.contains(namefiltter))
                                  .length >
                              0)
                          ? calcDistance(widget.scannerState.discoveredDevices
                                      .where((element) =>
                                          element.name.contains(namefiltter))
                                      .first
                                      .rssi) <
                                  rangeWarning
                              ? Image.asset(
                                  'assets/posbodyok.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/posbody2.png',
                                  fit: BoxFit.cover,
                                )
                          : Image.asset(
                              'assets/posbody.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                    Align(
                        alignment: const AlignmentDirectional(0.2, -0.3),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                          child: (widget.scannerState.discoveredDevices
                                      .where((element) =>
                                          element.name.contains(namefiltter))
                                      .length >
                                  0)
                              ? Text(calcDistance(widget
                                          .scannerState.discoveredDevices
                                          .where((element) => element.name
                                              .contains(namefiltter))
                                          .first
                                          .rssi)
                                      .toStringAsFixed(2) +
                                  " m")
                              : const Text(""),
                        )),
                    Align(
                        alignment: const Alignment(1, 0),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: (widget.scannerState.discoveredDevices
                                      .where((element) =>
                                          element.name.contains(namefiltter))
                                      .length >
                                  0)
                              ? calcDistance(widget
                                          .scannerState.discoveredDevices
                                          .where((element) => element.name
                                              .contains(namefiltter))
                                          .first
                                          .rssi) <
                                      rangeWarning
                                  ? Text("OK")
                                  : Text("Warning")
                              : const Text("Not found"),
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: const Text('Scan'),
                onPressed:
                    !widget.scannerState.scanIsInProgress && _isValidUuidInput()
                        ? _startScanning
                        : null,
              ),
              ElevatedButton(
                child: const Text('Stop'),
                onPressed: widget.scannerState.scanIsInProgress
                    ? widget.stopScan
                    : null,
              ),
            ],
          ),
          Flexible(
            child: ListView(
              children: widget.scannerState.discoveredDevices
                  .where((element) => element.name.contains(namefiltter))
                  .map(
                    (device) => ListTile(
                      title: Text(device.name),
                      subtitle: Text("${device.id}\nRSSI:${device.rssi}"),
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
          organ = 0.0;
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
}
