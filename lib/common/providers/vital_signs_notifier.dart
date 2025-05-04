import 'package:flutter_riverpod/flutter_riverpod.dart';

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
