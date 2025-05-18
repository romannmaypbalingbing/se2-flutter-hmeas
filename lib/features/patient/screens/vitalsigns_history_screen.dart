import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:vitawatch/features/patient/screens/components/bottom_navigation_bar.dart';
import 'package:vitawatch/features/patient/routes/patient_routes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vitawatch/common/providers/vital_service_provider.dart';
import 'package:vitawatch/common/providers/vital_signs_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class VitalsignsHistoryScreen extends ConsumerStatefulWidget {
  const VitalsignsHistoryScreen({super.key});

  @override
  ConsumerState<VitalsignsHistoryScreen> createState() =>
      _VitalsignsHistoryScreenState();
}

enum VitalType { heartRate, spo2, temp }

class _VitalsignsHistoryScreenState
    extends ConsumerState<VitalsignsHistoryScreen> {
  String _selectedRange = '1 hour';
  final List<String> _ranges = ['1 hour', '3 hour', '6 hour', '1 day'];
  VitalType _selectedVital = VitalType.heartRate;

  final Map<VitalType, String> vitalKeys = {
    VitalType.heartRate: 'heart_rate',
    VitalType.spo2: 'spo2',
    VitalType.temp: 'temperature',
  };

  final Map<VitalType, String> _vitalLabels = {
    VitalType.heartRate: 'Heart Rate',
    VitalType.spo2: 'SPO2',
    VitalType.temp: 'Temp',
  };

  final Map<VitalType, String> _vitalUnits = {
    VitalType.heartRate: 'bpm',
    VitalType.spo2: '%',
    VitalType.temp: '°C',
  };

  final Map<VitalType, IconData> _vitalIcons = {
    VitalType.heartRate: Icons.favorite,
    VitalType.spo2: Icons.water_drop,
    VitalType.temp: Icons.thermostat,
  };

  final Map<VitalType, Color> _vitalColors = {
    VitalType.heartRate: Color(0xFF48E389),
    VitalType.spo2: Color(0xFF4D64FF),
    VitalType.temp: Color(0xFF55BFFF),
  };

  // Mock history data
  // final Map<VitalType, List<Map<String, String>>> _historyData = {
  //   VitalType.heartRate: [
  //     {'date': '2024-06-01', 'value': '75 bpm'},
  //     {'date': '2024-05-30', 'value': '80 bpm'},
  //     {'date': '2024-05-29', 'value': '72 bpm'},
  //     {'date': '2024-05-28', 'value': '90 bpm'},
  //   ],
  //   VitalType.spo2: [
  //     {'date': '2024-06-01', 'value': '98 %'},
  //     {'date': '2024-05-30', 'value': '97 %'},
  //     {'date': '2024-05-29', 'value': '99 %'},
  //     {'date': '2024-05-28', 'value': '98 %'},
  //   ],
  //   VitalType.temp: [
  //     {'date': '2024-06-01', 'value': '36.7 °C'},
  //     {'date': '2024-05-30', 'value': '36.5 °C'},
  //     {'date': '2024-05-29', 'value': '36.8 °C'},
  //     {'date': '2024-05-28', 'value': '36.6 °C'},
  //   ],
  // };

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final vitalsAsync = ref.watch(vitalStreamProvider);

    return vitalsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (vitalsList) {
        if (vitalsList.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        // Convert to FlSpot for charts
        final List<FlSpot> heartRateSpots = [];
        final List<FlSpot> spo2Spots = [];
        final List<FlSpot> temperatureSpots = [];
        final history = vitalsList;

        for (int i = 0; i < vitalsList.length; i++) {
          final vital = vitalsList[i];

          final heartRate = (vital['heart_rate'] as num?)?.toDouble();
          final spo2 = (vital['spo2'] as num?)?.toDouble();
          final temperature = (vital['temperature'] as num?)?.toDouble();

          final x = i.toDouble();
          if (heartRate != null) heartRateSpots.add(FlSpot(x, heartRate));
          if (spo2 != null) spo2Spots.add(FlSpot(x, spo2));
          if (temperature != null) temperatureSpots.add(FlSpot(x, temperature));
        }
        print(vitalsAsync);

        return Scaffold(
          backgroundColor: const Color(0xFFF1F5FD),
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 260,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF081C5D), Color(0xFF2952D9)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '  Vitals History',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontFamily: 'ClashDisplay',
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true, //see changes when
                                hint: Text(
                                  'Select Range',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                value: _selectedRange,
                                items:
                                    _ranges
                                        .map(
                                          (range) => DropdownMenuItem(
                                            value: range,
                                            child: Text(
                                              range,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {
                                  if (value != null)
                                    setState(() => _selectedRange = value);
                                },
                                buttonStyleData: const ButtonStyleData(
                                  height: 40,
                                  width: 60,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF7893FF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Tabs Row (above graph)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            VitalType.values.map((type) {
                              final isSelected = _selectedVital == type;
                              return GestureDetector(
                                onTap:
                                    () => setState(() => _selectedVital = type),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? _vitalColors[type]!.withValues(
                                              alpha: 0.15,
                                            )
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? _vitalColors[type]!.withValues(
                                                alpha: 0.15,
                                              )
                                              : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor: _vitalColors[type],
                                        child: Icon(
                                          _vitalIcons[type],
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _vitalLabels[type]!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  isSelected
                                                      ? _vitalColors[type]
                                                      : Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // Graph Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Builder(
                          builder: (context) {
                            List<FlSpot> spots;
                            Color vitalColor;
                            String vitalLabel;
                            String vitalUnit;
                            VitalType vitalType;

                            switch (_selectedVital) {
                              case VitalType.heartRate:
                                spots = heartRateSpots;
                                vitalColor = _vitalColors[VitalType.heartRate]!;
                                vitalLabel = _vitalLabels[VitalType.heartRate]!;
                                vitalUnit = _vitalUnits[VitalType.heartRate]!;
                                vitalType = VitalType.heartRate;
                                break;
                              case VitalType.spo2:
                                spots = spo2Spots;
                                vitalColor = _vitalColors[VitalType.spo2]!;
                                vitalLabel = _vitalLabels[VitalType.spo2]!;
                                vitalUnit = _vitalUnits[VitalType.spo2]!;
                                vitalType = VitalType.spo2;
                                break;
                              case VitalType.temp:
                                spots = temperatureSpots;
                                vitalColor = _vitalColors[VitalType.temp]!;
                                vitalLabel = _vitalLabels[VitalType.temp]!;
                                vitalUnit = _vitalUnits[VitalType.temp]!;
                                vitalType = VitalType.temp;
                                break;
                            }

                            return SizedBox(
                              height: 200,
                              child: LineChart(
                                _vitalsChartData(
                                  spots,
                                  vitalColor,
                                  vitalLabel,
                                  vitalUnit,
                                  vitalType,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      // History List
                      const Text(
                        'History',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          fontFamily: 'ClashDisplay',
                        ),
                      ),
                      const SizedBox(height: 8),

                      Expanded(
                        child: ListView.separated(
                          itemCount: vitalsList.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final item = vitalsList[index];

                            // Format timestamp (assuming it's stored as a string or int)
                            final timestamp =
                                item['timestamp']?.toString() ?? '';
                            final dateTime =
                                DateTime.tryParse(timestamp) ??
                                DateTime.fromMillisecondsSinceEpoch(
                                  int.tryParse(timestamp) ?? 0,
                                );
                            final formattedDate =
                                dateTime != null
                                    ? '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}'
                                    : timestamp;

                            // Get key for selected vital
                            final key = vitalKeys[_selectedVital];
                            final vitalValueRaw = item[key];
                            final vitalUnit = _vitalUnits[_selectedVital];
                            final vitalValue =
                                vitalValueRaw != null
                                    ? '$vitalValueRaw $vitalUnit'
                                    : 'N/A';

                            // Use the label, color, and icon maps for UI consistency
                            final vitalTypeLabel =
                                _vitalLabels[_selectedVital]!;
                            final vitalColor = _vitalColors[_selectedVital]!;
                            final vitalIcon = _vitalIcons[_selectedVital]!;

                            return Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: vitalColor.withOpacity(
                                        0.2,
                                      ),
                                      child: Icon(vitalIcon, color: vitalColor),
                                    ),
                                    const SizedBox(width: 25),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$vitalTypeLabel: $vitalValue',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'OpenJakartaS',
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          formattedDate,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        );
      },
    );
  }
}

LineChartData _vitalsChartData(
  List<FlSpot> spots,
  Color color,
  String label,
  String unit,
  VitalType selectedVital,
) {
  String formatTimestamp(double value) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  return LineChartData(
    gridData: FlGridData(show: true, drawVerticalLine: false),

    titlesData: FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval:
              (spots.length > 1)
                  ? (spots.last.x - spots.first.x) / (spots.length - 1)
                  : 1,
          getTitlesWidget: (value, meta) {
            // Show time for the x-axis label
            final text = formatTimestamp(value);
            return SideTitleWidget(
              meta: meta,
              // : meta.axisSide,
              child: Text(
                text,
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            );
          },
          reservedSize: 30,
        ),
      ),

      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true, reservedSize: 40),
      ),

      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    ),

    borderData: FlBorderData(show: true),

    lineBarsData: [
      LineChartBarData(
        isCurved: true,
        color: color,
        barWidth: 3,
        spots: spots,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: true,
          color: color.withValues(alpha: 0.2),
        ),
      ),
    ],

    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            return LineTooltipItem(
              '${spot.y.toStringAsFixed(selectedVital == VitalType.temp ? 1 : 0)} $unit\n${formatTimestamp(spot.x)}',
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          }).toList();
        },
      ),
      handleBuiltInTouches: true,
    ),
  );
}
