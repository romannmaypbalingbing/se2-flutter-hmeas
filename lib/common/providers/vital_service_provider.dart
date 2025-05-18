// vital_service_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/common/providers/vital_services.dart';

final vitalServicesProvider = Provider<VitalServices>((ref) {
  return VitalServices();
});

final vitalStreamProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  final vitalServices = ref.watch(vitalServicesProvider);
  return vitalServices.streamVitals(limit: 50);
});
