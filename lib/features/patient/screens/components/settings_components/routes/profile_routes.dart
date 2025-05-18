import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/current_med.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/med_details.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/settings.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/medical_conditions.dart';
import 'package:vitawatch/features/patient/screens/components/settings_components/medical_info.dart';
import 'package:vitawatch/features/patient/screens/profile_screen.dart';

class PatientRoutes {
  // Path definitions for auth routes
  static const String profile = '/profile';
  static const String currentMed = '/current-med';
  static const String medDetails = '/med-details';
  static const String settings = '/settings';
  static const String medicalConditions = '/medical-conditions';
  static const String medicalInfo = '/medical-info';

  // Defines the app's routing structure using GoRouter
  static final List<GoRoute> profileRoutes = [
    GoRoute(path: profile, builder: (context, state) => const ProfileScreen()),
    // GoRoute(
    //   path: currentMed,
    //   builder: (context, state) => const CurrentMedScreen(),
    // ),
    // GoRoute(
    //   path: medDetails,
    //   builder: (context, state) => const MedDetailsScreen(),
    // ),
    // GoRoute(
    //   path: medicalConditions,
    //   builder: (context, state) => const MedicalConditionsScreen(),
    // ),
    GoRoute(
      path: medicalInfo,
      builder: (context, state) => const MedicalInfoScreen(),
    ),
    // GoRoute(
    //   path: settings,
    //   builder: (context, state) => const SettingsScreen(),
    // ),
  ];
}
