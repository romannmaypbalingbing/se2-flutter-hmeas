// This file contains google sign in something chuhcu and registration and loggin in logic
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthService({FirebaseAuth? fireBaseAuth, GoogleSignIn? googleSignIn})
    : _auth = fireBaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'USER_CANCELLED',
          message: 'Google Sign in cancelled by user.',
        );
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      //handle both sign in and sign up
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Google Sign In failed: $e');
    }
  }

  //Email/Password sign in method
  Future<UserCredential> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Email/Password Sign-In failed: $e');
    }
  }

  //Sign up method
  Future<UserCredential> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Email/Password Sign-Up failed: $e');
    }
  }

  //Sign out method
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut(); // Sign out from Google
      await _auth.signOut(); // Sign out from Firebase
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }
}
