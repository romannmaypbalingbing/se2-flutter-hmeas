// /// A [ChangeNotifier] that manages the authentication state of the user at the startup.
// ///
// /// This class listens to authentication state changes from Firebase and
// /// provides methods for signing in and signing out. It also exposes the
// /// current user and a loading state to indicate ongoing authentication
// /// operations.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitawatch/features/auth/services/auth_service.dart';

class AuthStateNotifier extends ChangeNotifier {
  final AuthService _authService;

  AuthStateNotifier(this._authService) {
    _listenToAuthChanges();
  }

  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _listenToAuthChanges() {
    _authService.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    _setLoading(true);
    try {
      final credential = await _authService.signInWithGoogle();
      _user = credential.user;
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> singInWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      final credential = await _authService.signInWithEmailPassword(
        email,
        password,
      );
      _user = credential.user;
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      final credential = await _authService.signUpWithEmailPassword(
        email,
        password,
      );
      _user = credential.user;
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _user = null;
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }
}
