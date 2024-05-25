import 'package:flutter/material.dart';
import 'package:smartibe/dismac.dart';
import 'package:smartibe/screens/allsensor.dart';
import 'package:smartibe/screens/homescreen.dart';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:smartibe/src/ble/ble_device_connector.dart';
import 'package:smartibe/src/ble/ble_device_interactor.dart';
import 'package:smartibe/src/ble/ble_scanner.dart';
import 'package:smartibe/src/ble/ble_status_monitor.dart';
import 'package:provider/provider.dart';
import 'src/ble/ble_logger.dart';

const _themeColor = Colors.lightGreen;

void main() {
  String titlename = 'Flutter Reactive BLE example';

  WidgetsFlutterBinding.ensureInitialized();
  final bleLogger = BleLogger();
  final ble = FlutterReactiveBle();
  final scanner = BleScanner(ble: ble, logMessage: bleLogger.addToLog);
  final monitor = BleStatusMonitor(ble);
  final connector = BleDeviceConnector(
    ble: ble,
    logMessage: bleLogger.addToLog,
  );
  final serviceDiscoverer = BleDeviceInteractor(
    bleDiscoverServices: ble.discoverServices,
    readCharacteristic: ble.readCharacteristic,
    writeWithResponse: ble.writeCharacteristicWithResponse,
    writeWithOutResponse: ble.writeCharacteristicWithoutResponse,
    subscribeToCharacteristic: ble.subscribeToCharacteristic,
    logMessage: bleLogger.addToLog,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DisMac>(create: (i) => DisMac()),
        Provider.value(value: scanner),
        Provider.value(value: monitor),
        Provider.value(value: connector),
        Provider.value(value: serviceDiscoverer),
        Provider.value(value: bleLogger),
        StreamProvider<BleScannerState?>(
          create: (_) => scanner.state,
          initialData: const BleScannerState(
            discoveredDevices: [],
            scanIsInProgress: false,
          ),
        ),
        StreamProvider<BleStatus?>(
          create: (_) => monitor.state,
          initialData: BleStatus.unknown,
        ),
        StreamProvider<ConnectionStateUpdate>(
          create: (_) => connector.state,
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bottom Navigation Bar',
      home: HomeScreen(),
    );
  }
}
