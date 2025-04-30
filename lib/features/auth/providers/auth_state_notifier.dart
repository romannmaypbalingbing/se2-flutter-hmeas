/// A [ChangeNotifier] that manages the authentication state of the user at the startup.
///
/// This class listens to authentication state changes from Firebase and
/// provides methods for signing in and signing out. It also exposes the
/// current user and a loading state to indicate ongoing authentication
/// operations.
class AuthStateNotifier extends ChangeNotifier {
  /// The currently authenticated [User], or `null` if no user is signed in.
  User? get user;

  /// A boolean indicating whether an authentication operation is in progress.
  bool get isLoading;

  /// Creates an instance of [AuthStateNotifier] and starts listening to
  /// authentication state changes from Firebase.
  AuthStateNotifier();

  /// Signs in a user with the provided [email] and [password].
  ///
  /// This method sets the loading state to `true` while the sign-in operation
  /// is in progress. If an error occurs during sign-in, it is logged in debug
  /// mode. The loading state is reset to `false` after the operation completes.
  ///
  /// - Parameters:
  ///   - email: The email address of the user.
  ///   - password: The password of the user.
  Future<void> signIn(String email, String password);

  /// Signs out the currently authenticated user.
  ///
  /// This method sets the loading state to `true` while the sign-out operation
  /// is in progress. If an error occurs during sign-out, it is logged in debug
  /// mode. The loading state is reset to `false` after the operation completes.
  Future<void> signOut();
}
        print('Sign-out error: $e');
      }
    } finally {
      _setLoading(false);
    }
  } 
