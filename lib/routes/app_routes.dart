import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:VitaWatch/common/splash_screen.dart';

//The main router for the app, configuring navigation with GoRouter
final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (constext, state) => const SplashScreen()),
  ],
);
