// This file contains test data for the patient feature.
// It includes sample data for various health metrics such as temperature, heart rate, SpO2, and blood pressure.
import 'package:fl_chart/fl_chart.dart';

final List<FlSpot> tempData = [
  FlSpot(0, 36.6),
  FlSpot(1, 36.7),
  FlSpot(2, 36.9),
];

final List<FlSpot> heartRateData = [
  FlSpot(0, 72),
  FlSpot(1, 75),
  FlSpot(2, 70),
];

final List<FlSpot> spo2Data = [FlSpot(0, 98), FlSpot(1, 97), FlSpot(2, 99)];

final List<FlSpot> bpData = [FlSpot(0, 120), FlSpot(1, 122), FlSpot(2, 118)];
