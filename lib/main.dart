import 'package:flutter/material.dart';
import 'package:smartibe/dismac.dart';
import 'package:smartibe/screens/allsensor.dart';
import 'package:smartibe/screens/homescreen.dart';
import 'package:smartibe/screens/loginscreen.dart';
import 'package:smartibe/screens/positionxyscreen.dart';
import 'package:smartibe/screens/registerscreen.dart';
import 'package:smartibe/screens/UserProfile.dart';
import 'package:smartibe/screens/navpage.dart';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:smartibe/src/ble/ble_device_connector.dart';
import 'package:smartibe/src/ble/ble_device_interactor.dart';
import 'package:smartibe/src/ble/ble_scanner.dart';
import 'package:smartibe/src/ble/ble_status_monitor.dart';
import 'package:smartibe/src/ui/ble_status_screen.dart';
import 'package:smartibe/src/ui/device_list.dart';
import 'package:provider/provider.dart';
import 'bluetoothmain.dart';
import 'src/ble/ble_logger.dart';

const _themeColor = Colors.lightGreen;

void main() {
  String titlename = 'Flutter Reactive BLE example';

  WidgetsFlutterBinding.ensureInitialized();
  final _bleLogger = BleLogger();
  final _ble = FlutterReactiveBle();
  final _scanner = BleScanner(ble: _ble, logMessage: _bleLogger.addToLog);
  final _monitor = BleStatusMonitor(_ble);
  final _connector = BleDeviceConnector(
    ble: _ble,
    logMessage: _bleLogger.addToLog,
  );
  final _serviceDiscoverer = BleDeviceInteractor(
    bleDiscoverServices: _ble.discoverServices,
    readCharacteristic: _ble.readCharacteristic,
    writeWithResponse: _ble.writeCharacteristicWithResponse,
    writeWithOutResponse: _ble.writeCharacteristicWithoutResponse,
    subscribeToCharacteristic: _ble.subscribeToCharacteristic,
    logMessage: _bleLogger.addToLog,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DisMac>(create: (i) => DisMac()),
        Provider.value(value: _scanner),
        Provider.value(value: _monitor),
        Provider.value(value: _connector),
        Provider.value(value: _serviceDiscoverer),
        Provider.value(value: _bleLogger),
        StreamProvider<BleScannerState?>(
          create: (_) => _scanner.state,
          initialData: const BleScannerState(
            discoveredDevices: [],
            scanIsInProgress: false,
          ),
        ),
        StreamProvider<BleStatus?>(
          create: (_) => _monitor.state,
          initialData: BleStatus.unknown,
        ),
        StreamProvider<ConnectionStateUpdate>(
          create: (_) => _connector.state,
          initialData: const ConnectionStateUpdate(
            deviceId: 'Unknown device',
            connectionState: DeviceConnectionState.disconnected,
            failure: null,
          ),
        ),
      ],
      child: MaterialApp(
          title: titlename,
          color: _themeColor,
          theme: ThemeData(primarySwatch: _themeColor),
          home: const AllSensor() //HomeScreen(),
          ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar',
      home: HomeScreen(),
    );
  }
}
