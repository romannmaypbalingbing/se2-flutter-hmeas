// This file is a component of the dashboard which displays the status of the device
// whether it is connected or not >> the vital signs can be monitored
// whether it is connected through wi-fi or lo-ra
// the battery level of the device >> TODO: implement checker or notifier for user

import 'package:flutter/material.dart';

class DeviceStatus extends StatefulWidget {
  const DeviceStatus({
    super.key,
    required this.connected,
    required this.batteryLevel,
    required this.connectionType,
  });

  final bool connected;
  final int batteryLevel;
  final String connectionType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2)),
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Device Status',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w200,
              fontFamily: 'OpenSansJakarta',
            ),
          ),
          SizedBox(height: 4),
          Inkwell(),
        ],
      ),
    );
  }
}
