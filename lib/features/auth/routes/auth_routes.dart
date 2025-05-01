import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/auth/screens/create_password_screen.dart';
import 'package:vitawatch/features/auth/screens/login_screen.dart';
import 'package:vitawatch/features/auth/screens/account_type_screen.dart';
import 'package:vitawatch/features/auth/screens/mobile_number_screen.dart';
import 'package:vitawatch/features/auth/screens/registration_screen.dart';
import 'package:vitawatch/features/auth/screens/verif_otp_screen.dart';
import 'package:vitawatch/features/patient/screens/dashboard_screen.dart';

class AuthRoutes {
  // Path definitions for auth routes
  static const String login = '/login';
  static const String registration = '/registration';
  static const String accountType = '/account-type';
  static const String dashboard = '/dashboard';
  static const String createPassword = '/create-password';
  static const String mobileNumber = '/mobile-number';
  static const String verifyOTP = '/verify-otp';

  // Defines the app's routing structure using GoRouter
  static final List<GoRoute> authRoutes = [
    GoRoute(path: login, builder: (context, state) => const Login()),
    GoRoute(
      path: accountType,
      builder: (context, state) => const AccountTypeScreen(),
    ),
    GoRoute(
      path: registration,
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: createPassword,
      builder: (context, state) => const CreatePasswordScreen(),
    ),
    GoRoute(
      path: mobileNumber,
      builder: (context, state) => const MobileNumberScreen(),
    ),
    GoRoute(
      path: verifyOTP,
      builder: (context, state) => const VerifyOTPScreen(),
    ),
    //temp
    GoRoute(
      path: dashboard,
      builder:
          (context, state) =>
              const DashboardScreen(), // Placeholder for dashboard screen
    ),
  ];
}
