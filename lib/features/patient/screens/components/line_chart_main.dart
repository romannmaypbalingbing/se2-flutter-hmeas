import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/common/providers/vital_signs_notifier.dart';
import 'package:vitawatch/features/patient/test/test_data.dart';

class LineChartMain extends ConsumerStatefulWidget {
  const LineChartMain({super.key});

  @override
  ConsumerState<LineChartMain> createState() => _LineChartMainState();
}

class _LineChartMainState extends ConsumerState<LineChartMain> {
  bool isShowingMainData = true;

  @override
  Widget build(BuildContext context) {
    final vitalSigns = ref.watch(vitalSignsProvider);

    // Uncomment below if using actual data:
    // final List<FlSpot> tempData = (vitalSigns['temperature'] ?? []).cast<FlSpot>();
    // final List<FlSpot> heartRateData = (vitalSigns['heartRate'] ?? []).cast<FlSpot>();
    // final List<FlSpot> spo2Data = (vitalSigns['spo2'] ?? []).cast<FlSpot>();

    final List<FlSpot> tempData = testTempData;
    final List<FlSpot> heartRateData = testHeartRateData;
    final List<FlSpot> spo2Data = testSpo2Data;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Vital Signs Overview',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'ClashDisplay',
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          isShowingMainData = !isShowingMainData;
                        });
                      },
                    ),
                  ],
                ),

                Wrap(
                  spacing: 12,
                  children: [
                    const LegendItem(color: Colors.blue, label: 'SpO₂'),
                    const LegendItem(color: Colors.red, label: 'Heart Rate'),
                    const LegendItem(
                      color: Colors.orange,
                      label: 'Temperature',
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _LineChart(
                      isShowingMainData: isShowingMainData,
                      tempData: tempData,
                      heartRateData: heartRateData,
                      spo2Data: spo2Data,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({
    required this.isShowingMainData,
    required this.tempData,
    required this.heartRateData,
    required this.spo2Data,
  });

  final bool isShowingMainData;
  final List<FlSpot> tempData;
  final List<FlSpot> heartRateData;
  final List<FlSpot> spo2Data;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData
          ? sampleDataFromTestData(tempData, heartRateData, spo2Data)
          : altSampleData(),
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData sampleDataFromTestData(
    List<FlSpot> temp,
    List<FlSpot> heart,
    List<FlSpot> spo2,
  ) {
    final allSpots = [...temp, ...heart, ...spo2];
    final minX = allSpots.map((e) => e.x).reduce(min);
    final maxX = allSpots.map((e) => e.x).reduce(max);
    final minY = allSpots.map((e) => e.y).reduce(min) - 5;
    final maxY = allSpots.map((e) => e.y).reduce(max) + 5;

    return LineChartData(
      lineTouchData: LineTouchData(enabled: true),
      gridData: const FlGridData(show: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10,
            getTitlesWidget:
                (value, meta) => Text(
                  value.toInt().toString(),
                  style: TextStyle(fontSize: 10),
                ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget:
                (value, meta) => Text(
                  value.toInt().toString(),
                  style: TextStyle(fontSize: 10),
                ),
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.grey, width: 2),
          left: BorderSide(color: Colors.grey, width: 2),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          color: Colors.orange,
          barWidth: 4,
          dotData: const FlDotData(show: false),
          spots: temp,
        ),
        LineChartBarData(
          isCurved: true,
          color: Colors.red,
          barWidth: 4,
          dotData: const FlDotData(show: false),
          spots: heart,
        ),
        LineChartBarData(
          isCurved: true,
          color: Colors.blue,
          barWidth: 4,
          dotData: const FlDotData(show: false),
          spots: spo2,
        ),
      ],
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
    );
  }

  LineChartData altSampleData() {
    return LineChartData(
      lineBarsData: [],
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: false),
    );
  }
}

class LegendItem extends StatelessWidget {
  const LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
