import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Sign up  or create account with email and password
  Future<UserCredential?> signupUser(
    String email,
    String password,
    String username,
  ) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name (username)
      await userCredential.user?.updateDisplayName(username);

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in or login  with email and password
  Future<UserCredential?> loginUser(String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // forgot password (Send password reset email)
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Sign out user or logout
  Future<void> signoutUser() async {
    await auth.signOut();
  }

  // Get current user
  User? get currentUser => auth.currentUser;

  // Listen to auth state changes
  Stream<User?> get authChanges => auth.authStateChanges();
}
