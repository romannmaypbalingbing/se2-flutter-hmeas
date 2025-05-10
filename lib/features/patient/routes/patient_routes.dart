import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/patient/screens/dashboard_screen.dart';
import 'package:vitawatch/features/patient/screens/vitalsigns_history_screen.dart';
import 'package:vitawatch/features/patient/screens/emergency_alert_screen.dart';
import 'package:vitawatch/features/patient/screens/profile_screen.dart';

class PatientRoutes {
  // Path definitions for auth routes
  static const String dashboard = '/dashboard';
  static const String vitalSignsHistory = '/vital-signs-history';
  static const String emergencyAlert = '/emergency-alert';
  static const String profile = '/profile';

  // Defines the app's routing structure using GoRouter
  static final List<GoRoute> patientRoutes = [
    GoRoute(
      path: dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: vitalSignsHistory,
      builder: (context, state) => const VitalsignsHistoryScreen(),
    ),
    GoRoute(
      path: emergencyAlert,
      builder: (context, state) => const EmergencyAlertScreen(),
    ),
  ];
}
