import 'package:go_router/go_router.dart';
import 'package:vitawatch/features/auth/screens/account_type_screen.dart';

List<GoRoute> authRoutes = [
  GoRoute(
    path: '/account-type',
    builder: (context, state) => const AccountTypeScreen(),
  ),
];
