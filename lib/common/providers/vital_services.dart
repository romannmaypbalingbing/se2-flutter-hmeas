// vital_services.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class VitalServices {
  final DatabaseReference _database =
      FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL:
            'https://vitawatch-default-rtdb.asia-southeast1.firebasedatabase.app',
      ).ref();

  Stream<List<Map<String, dynamic>>> streamVitals({int limit = 50}) {
    final ref = _database.child('vitals').orderByKey().limitToLast(limit);

    return ref.onValue.map((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        final sortedEntries =
            data.entries.toList()..sort(
              (a, b) => a.key.compareTo(b.key),
            ); // Optional: Sort by key (timestamp)

        return sortedEntries.map((entry) {
          final value = entry.value as Map<dynamic, dynamic>;
          print(value);
          return {
            'heart_rate': value['heart_rate'],
            'spo2': value['spo2'],
            'temperature': value['temperature'],
            'timestamp': entry.key,
            'useruid': value['useruid'],
          };
        }).toList();
      } else {
        return [];
      }
    });
  }
}
