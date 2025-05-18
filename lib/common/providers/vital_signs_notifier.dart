//access data without refetching and automatically update UI when data changes using riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
//Manage state of vital signs data, including temperature, heart rate, and SpO2 (blood pressure)
import 'package:vitawatch/common/providers/vital_service_provider.dart';

class VitalSignsNotifier extends StateNotifier<Map<String, List<double>>> {
  VitalSignsNotifier()
    : super({
        'temperature': [],
        'heartRate': [],
        'spo2': [],
        //'bloodPressure': [], TODO: check if blood pressure can be measured
      });

  //Methods to set data
  void setTemperature(List<double> newData) {
    state = {...state, 'temperature': newData};
  }

  void setHeartRate(List<double> newData) {
    state = {...state, 'heartRate': newData};
  }

  void setSpo2(List<double> newData) {
    state = {...state, 'spo2': newData};
  }
}

final vitalSignsProvider =
    StateNotifierProvider<VitalSignsNotifier, Map<String, List<double>>>(
      (ref) => VitalSignsNotifier(),
    );
