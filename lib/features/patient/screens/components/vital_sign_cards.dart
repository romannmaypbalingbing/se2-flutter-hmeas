import 'package:flutter/material.dart';

class VitalSignCards extends StatefulWidget {
  final List<Map<String, dynamic>> vitalData;
  const VitalSignCards({super.key, required this.vitalData});

  @override
  State<VitalSignCards> createState() => _VitalSignCardsState();
}

class _VitalSignCardsState extends State<VitalSignCards> {
  @override
  Widget build(BuildContext context) {
    final vitalData = widget.vitalData;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 180, // Adjust height to fit the cards properly
        child: ListView.separated(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: vitalData.length,
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            final vital = vitalData[index];
            return _VitalBox(label: vital['label']!, value: vital['value']!);
          },
        ),
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
      width: 150, // Fixed width for horizontal layout
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
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
