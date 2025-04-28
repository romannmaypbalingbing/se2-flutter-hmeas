// This file defines the app's routing structure using the GoRouter package.
import 'package:go_router/go_router.dart';
import 'package:vitawatch/common/splash_screen.dart';
import 'package:vitawatch/features/auth/routes/auth_routes.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    if (state.fullPath == '/') {
      await Future.delayed(const Duration(seconds: 3));
      return '/account-type';
    }
    return null; // Don't redirect for other routes
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    ...authRoutes,
    // ... other routes
  ],
);
