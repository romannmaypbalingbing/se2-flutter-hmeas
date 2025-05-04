// This file contains test data for the patient feature.
// It includes sample data for various health metrics such as temperature, heart rate, SpO2, and blood pressure.
import 'package:fl_chart/fl_chart.dart';

final List<FlSpot> testTempData = [
  FlSpot(0, 36.6),
  FlSpot(1, 36.7),
  FlSpot(2, 36.9),
  FlSpot(3, 35.0),
  FlSpot(4, 37.2),
  FlSpot(5, 36.8),
];

final List<FlSpot> testHeartRateData = [
  FlSpot(0, 100),
  FlSpot(1, 75),
  FlSpot(2, 70),
  FlSpot(3, 80),
  FlSpot(4, 90),
  FlSpot(5, 85),
];

final List<FlSpot> testSpo2Data = [
  FlSpot(0, 98),
  FlSpot(1, 97),
  FlSpot(2, 99),
  FlSpot(3, 96),
  FlSpot(4, 95),
  FlSpot(5, 100),
];

final List<FlSpot> bpData = [
  FlSpot(0, 120),
  FlSpot(1, 122),
  FlSpot(2, 118),
  FlSpot(3, 115),
  FlSpot(4, 110),
  FlSpot(5, 112),
];
