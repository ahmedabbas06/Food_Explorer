import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  User? currentUser;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<void> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      currentUser = userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'Incorrect email or password.';
          break;

        case 'invalid-email':
          errorMessage = 'Please enter a valid email address.';
          break;

        case 'user-not-found':
          errorMessage = 'No account found with this email.';
          break;

        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;

        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;

        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later.';
          break;

        case 'network-request-failed':
          errorMessage = 'Please check your internet connection.';
          break;

        default:
          errorMessage = 'Something went wrong. Please try again.';
      }
    } catch (e) {
      errorMessage = 'Something went wrong. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();

    currentUser = null;
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      currentUser = credential.user;

      debugPrint('SIGNUP SUCCESS: ${currentUser?.email}');
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;

      debugPrint('SIGNUP ERROR: ${e.code}');
      debugPrint('SIGNUP ERROR: ${e.message}');
    } catch (e) {
      errorMessage = e.toString();

      debugPrint('SIGNUP ERROR: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkCurrentUser() async {
    isLoading = true;
    notifyListeners();

    currentUser = firebaseAuth.currentUser;

    isLoading = false;
    notifyListeners();
  }

  Future<void> forgotPassword(String email) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      debugPrint('RESET EMAIL: $email');

      await firebaseAuth.sendPasswordResetEmail(email: email.trim());

      debugPrint('RESET EMAIL SENT SUCCESSFULLY');
    } on FirebaseAuthException catch (e) {
      debugPrint('RESET ERROR CODE: ${e.code}');
      debugPrint('RESET ERROR MESSAGE: ${e.message}');

      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address.';
          break;

        case 'user-not-found':
          errorMessage = 'No account found with this email.';
          break;

        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;

        case 'network-request-failed':
          errorMessage = 'Please check your internet connection.';
          break;

        default:
          errorMessage = e.message ?? 'Something went wrong.';
      }
    } catch (e) {
      debugPrint('RESET UNKNOWN ERROR: $e');
      errorMessage = 'Something went wrong. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
