import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/guardian/screens/guardian_dashboard.dart';
import 'package:vitawatch/features/guardian/screens/guardian_profile.dart';

class GuardianRoutes {
  // Path definitions for auth routes
  static const String guardian_dashboard = '/guardian-dashboard';
  static const String guardian_profile = '/guardian-profile';

  // Defines the app's routing structure using GoRouter
  static final List<GoRoute> guardianRoutes = [
    GoRoute(
      path: guardian_dashboard,
      builder: (context, state) => const GuardianDashboardScreen(),
    ),
    GoRoute(
      path: guardian_profile,
      builder: (context, state) => const GuardianProfileScreen(),
    ),
  ];
}
