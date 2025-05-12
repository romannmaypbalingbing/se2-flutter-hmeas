import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/features/auth/services/auth_service.dart';
import 'package:vitawatch/features/auth/providers/auth_state_notifier.dart';

/// Providers for authentication and registration
/// These providers manage the state of the authentication process
/// and provide access to the authentication service.

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateNotifierProvider = ChangeNotifierProvider<AuthStateNotifier>((
  ref,
) {
  final authService = ref.watch(authServiceProvider);
  return AuthStateNotifier(authService, ref);
});

final registrationDataProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {},
);
