import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/features/auth/services/auth_service.dart';
import 'package:vitawatch/features/auth/providers/auth_state_notifier.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateNotifierProvider = ChangeNotifierProvider<AuthStateNotifier>((
  ref,
) {
  final authService = ref.watch(authServiceProvider);
  return AuthStateNotifier(authService);
});

final registrationDataProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {},
);
