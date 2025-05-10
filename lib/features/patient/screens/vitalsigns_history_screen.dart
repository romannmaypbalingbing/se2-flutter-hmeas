import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:vitawatch/features/patient/screens/components/bottom_navigation_bar.dart';
import 'package:vitawatch/features/patient/routes/patient_routes.dart';

class VitalsignsHistoryScreen extends StatefulWidget {
  const VitalsignsHistoryScreen({super.key});

  @override
  State<VitalsignsHistoryScreen> createState() =>
      _VitalsignsHistoryScreenState();
}

enum VitalType { heartRate, spo2, temp }

class _VitalsignsHistoryScreenState extends State<VitalsignsHistoryScreen> {
  String _selectedRange = '6 Month';
  final List<String> _ranges = ['1 Month', '3 Month', '6 Month', '1 Year'];
  VitalType _selectedVital = VitalType.heartRate;

  // Mock data for each vital
  final Map<VitalType, List<FlSpot>> _vitalSpots = {
    VitalType.heartRate: [
      FlSpot(0, 75),
      FlSpot(1, 80),
      FlSpot(2, 72),
      FlSpot(3, 90),
      FlSpot(4, 85),
      FlSpot(5, 78),
    ],
    VitalType.spo2: [
      FlSpot(0, 97),
      FlSpot(1, 98),
      FlSpot(2, 99),
      FlSpot(3, 97),
      FlSpot(4, 98),
      FlSpot(5, 98),
    ],
    VitalType.temp: [
      FlSpot(0, 36.5),
      FlSpot(1, 36.7),
      FlSpot(2, 36.6),
      FlSpot(3, 36.8),
      FlSpot(4, 36.9),
      FlSpot(5, 36.7),
    ],
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
  final Map<VitalType, List<Map<String, String>>> _historyData = {
    VitalType.heartRate: [
      {'date': '2024-06-01', 'value': '75 bpm'},
      {'date': '2024-05-30', 'value': '80 bpm'},
      {'date': '2024-05-29', 'value': '72 bpm'},
      {'date': '2024-05-28', 'value': '90 bpm'},
    ],
    VitalType.spo2: [
      {'date': '2024-06-01', 'value': '98 %'},
      {'date': '2024-05-30', 'value': '97 %'},
      {'date': '2024-05-29', 'value': '99 %'},
      {'date': '2024-05-28', 'value': '98 %'},
    ],
    VitalType.temp: [
      {'date': '2024-06-01', 'value': '36.7 °C'},
      {'date': '2024-05-30', 'value': '36.5 °C'},
      {'date': '2024-05-29', 'value': '36.8 °C'},
      {'date': '2024-05-28', 'value': '36.6 °C'},
    ],
  };

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final vitalSpots = _vitalSpots[_selectedVital]!;
    final vitalLabel = _vitalLabels[_selectedVital]!;
    final vitalUnit = _vitalUnits[_selectedVital]!;
    final vitalIcon = _vitalIcons[_selectedVital]!;
    final vitalColor = _vitalColors[_selectedVital]!;
    final vitalValue =
        vitalSpots.last.y.toStringAsFixed(
          _selectedVital == VitalType.temp ? 1 : 0,
        ) +
        ' ' +
        vitalUnit;
    final history = _historyData[_selectedVital]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5FD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    'Vitals History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ClashDisplay',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
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
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value != null)
                            setState(() => _selectedRange = value);
                        },
                        icon: const Icon(Icons.keyboard_arrow_down),
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
                        onTap: () => setState(() => _selectedVital = type),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? _vitalColors[type]!.withOpacity(0.15)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? _vitalColors[type]!
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _vitalLabels[type]!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          isSelected
                                              ? _vitalColors[type]
                                              : Colors.black54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _vitalSpots[type]!.last.y.toStringAsFixed(
                                          type == VitalType.temp ? 1 : 0,
                                        ) +
                                        ' ' +
                                        _vitalUnits[type]!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isSelected
                                              ? _vitalColors[type]
                                              : Colors.black,
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
                child: Column(
                  children: [
                    // Line Chart
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        _vitalsChartData(
                          vitalSpots,
                          vitalColor,
                          vitalLabel,
                          vitalUnit,
                          _selectedVital,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Month labels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("AUG"),
                        Text("SEP"),
                        Text("OCT"),
                        Text("NOV"),
                        Text("DEC"),
                        Text("JAN"),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // History List
              const Text(
                'History',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),

              Expanded(
                child: ListView.separated(
                  itemCount: history.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = history[index];
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
                              backgroundColor: vitalColor.withOpacity(0.2),
                              child: Icon(vitalIcon, color: vitalColor),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['value']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['date']!,
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
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

// Line chart for vitals with tooltip
LineChartData _vitalsChartData(
  List<FlSpot> spots,
  Color color,
  String label,
  String unit,
  VitalType type,
) {
  return LineChartData(
    gridData: FlGridData(show: true, drawVerticalLine: false),
    titlesData: FlTitlesData(show: false),
    borderData: FlBorderData(show: false),
    lineBarsData: [
      LineChartBarData(
        isCurved: true,
        color: color,
        barWidth: 3,
        spots: spots,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: true, color: color.withOpacity(0.2)),
      ),
    ],
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        // tooltipBgColor: const Color(0xFF081C5D),
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            return LineTooltipItem(
              '${spot.y.toStringAsFixed(type == VitalType.temp ? 1 : 0)} $unit\n${_monthLabel(spot.x)}',
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          }).toList();
        },
      ),
      handleBuiltInTouches: true,
    ),
  );
}

String _monthLabel(double x) {
  const months = ['Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan'];
  return months[x.toInt().clamp(0, months.length - 1)];
}
