import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:smartibe/src/ui/ble_status_screen.dart';
import 'package:smartibe/src/ui/device_list.dart';
import 'package:provider/provider.dart';


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
