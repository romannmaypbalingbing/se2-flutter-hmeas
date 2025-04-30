// This file defines the app's routing structure using the GoRouter package.
import 'package:go_router/go_router.dart';
import 'package:vitawatch/common/splash_screen.dart';
import 'package:vitawatch/features/auth/routes/auth_routes.dart';

class AppRoutes {
  static const String splash = '/';
}

final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    ...AuthRoutes.authRoutes,
  ],
);
