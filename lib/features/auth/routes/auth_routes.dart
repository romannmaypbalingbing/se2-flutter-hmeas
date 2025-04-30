import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/auth/screens/login_screen.dart';
import 'package:vitawatch/features/auth/screens/account_type_screen.dart';

class AuthRoutes {
  // Path definitions for auth routes
  static const String login = '/login';
  static const String accountType = '/account-type';

  // Defines the app's routing structure using GoRouter
  static final List<GoRoute> authRoutes = [
    GoRoute(path: login, builder: (context, state) => const Login()),
    GoRoute(
      path: accountType,
      builder: (context, state) => const AccountTypeScreen(),
    ),
  ];
}
