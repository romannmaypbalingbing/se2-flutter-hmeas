// This is an authentication provider that handles user login and registration
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitawatch/features/auth/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateChangesProvider = StreamProvider((ref) {
  return ref.watch(authServiceProvider)._auth.authStateChanges();
});
