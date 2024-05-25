import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:smartibe/src/ble/ble_device_connector.dart';
import 'package:smartibe/src/ble/ble_device_interactor.dart';
import 'package:smartibe/src/ble/ble_scanner.dart';
import 'package:smartibe/src/ble/ble_status_monitor.dart';
import 'package:smartibe/src/ui/ble_status_screen.dart';
import 'package:smartibe/src/ui/device_list.dart';
import 'package:provider/provider.dart';

import 'src/ble/ble_logger.dart';

class BTHomeScreen extends StatelessWidget {
  const BTHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<BleStatus?>(
        builder: (_, status, __) {
          if (status == BleStatus.ready) {
            return const DeviceListScreen();
          } else {
            return BleStatusScreen(status: status ?? BleStatus.unknown);
          }
        },
      );
}
