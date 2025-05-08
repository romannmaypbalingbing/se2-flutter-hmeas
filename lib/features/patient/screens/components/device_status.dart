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
  State<DeviceStatus> createState() => _DeviceStatusState();
}

class _DeviceStatusState extends State<DeviceStatus> {
  bool _isDeviceOn = false;

  @override
  void initState() {
    super.initState();
    _isDeviceOn = widget.connected;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      width: 180,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Device Status',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'OpenSansJakarta',
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 4),

          SizedBox(
            width: double.infinity,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                null; // TODO: implement device on/off toggle
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7893FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text(
                'Connected',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'ClashDisplay',
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              SizedBox(
                width: 70,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7893FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('Lo-Ra'),
                ),
              ),

              const SizedBox(width: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.battery_full, color: Colors.white, size: 20),
                  Text(
                    '${widget.batteryLevel} %',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
