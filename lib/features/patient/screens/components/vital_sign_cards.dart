import 'package:flutter/material.dart';

class VitalSignCards extends StatefulWidget {
  const VitalSignCards({super.key});

  @override
  State<VitalSignCards> createState() => _VitalSignCardsState();
}

class _VitalSignCardsState extends State<VitalSignCards> {
  final List<Map<String, String>> vitalData = [
    {'label': 'Temperature', 'value': '36.7 °C'},
    {'label': 'SPO2', 'value': '98 %'},
    {'label': 'Heart Rate', 'value': '75 bpm'},
    {'label': 'Blood Pressure', 'value': '120/80 mmHg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children:
            vitalData
                .map(
                  (vital) =>
                      _VitalBox(label: vital['label']!, value: vital['value']!),
                )
                .toList(),
      ),
    );
  }
}

class _VitalBox extends StatelessWidget {
  final String label;
  final String value;

  const _VitalBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'OpenSansJakarta',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
