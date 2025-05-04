import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/common/providers/vital_signs_notifier.dart';

class LineChartMain extends ConsumerStatefulWidget {
  const LineChartMain({super.key});

  @override
  ConsumerState<LineChartMain> createState() => _LineChartMainState();
}

class _LineChartMainState extends ConsumerState<LineChartMain> {
  @override
  Widget build(BuildContext context) {
    final vitalSigns = ref.watch(vitalSignsProvider);

    final List<double> tempData =
        vitalSigns['temperature']?.cast<double>() ?? [];
    final List<double> heartRateData =
        vitalSigns['heartRate']?.cast<double>() ?? [];
    final List<double> spo2Data = vitalSigns['spo2']?.cast<double>() ?? [];

    //Build FlSpots (x = index, y = value)
    final List<FlSpot> tempSpots = [
      for (int i = 0; i < tempData.length; i++)
        FlSpot(i.toDouble(), tempData[i]),
    ];
    final List<FlSpot> hearRateSpots = [
      for (int i = 0; i < heartRateData.length; i++)
        FlSpot(i.toDouble(), heartRateData[i]),
    ];
    final List<FlSpot> spo2Spots = [
      for (int i = 0; i < spo2Data.length; i++)
        FlSpot(i.toDouble(), spo2Data[i]),
    ];

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
                const Text(
                  'Vital Signs Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'ClashDisplay',
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: _LineChart(
                    tempSpots: tempSpots,
                    heartRateSpots: hearRateSpots,
                    spo2Spots: spo2Spots,
                  ),
                ),

                // Container(
                //   height: 200,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: Colors.black12,
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: Center(
                //     child: Text(
                //       'Temp: ${vitalSigns['temperature']?.join(", ")}\nHeart Rate: ${vitalSigns['heartRate']?.join(", ")}',
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  final List<FlSpot> tempSpots;
  final List<FlSpot> heartRateSpots;
  final List<FlSpot> spo2Spots;

  const _LineChart({
    required this.tempSpots,
    required this.heartRateSpots,
    required this.spo2Spots,
  });

  @override
  Widget build(BuildContext context) {
    final maxX =
        [
          tempSpots.length.toDouble(),
          heartRateSpots.length.toDouble(),
          spo2Spots.length.toDouble(),
        ].reduce((a, b) => a > b ? a : b) -
        1;

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: maxX,
        minY: 30,
        maxY: 120,
        lineBarsData: [
          LineChartBarData(
            spots: tempSpots,
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: heartRateSpots,
            isCurved: true,
            color: Colors.red,
            barWidth: 3,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: spo2Spots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text('T${value.toInt()}'),
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text('${value.toInt()}'),
              reservedSize: 30,
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }
}
