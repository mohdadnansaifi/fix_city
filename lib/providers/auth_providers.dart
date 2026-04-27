import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/services/notification_service.dart';
import '../data/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _repo =
  AuthRepository();

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  User? user;
  bool isLoading = true;
  String? error;

  AuthProvider() {
    _init();
  }

  /// Listen auth state
  void _init() {
    _auth.authStateChanges().listen(
          (userData) {
        user = userData;
        isLoading = false;
        notifyListeners();
      },
    );
  }

  /// GOOGLE LOGIN
  Future<bool> loginWithGoogle() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result =
      await _repo
          .signInWithGoogle();

      if (result != null) {
        user = result.user;

        await _repo.saveUserToFirestore(
          user!,
          user!.displayName ?? "User",
          "",
          "",
          "",
          user!.photoURL ?? "",
        );

        await NotificationService().saveToken();

        return true;
      }


      error =
      "Google login cancelled";
      return false;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// EMAIL LOGIN
  Future<bool> loginWithEmail(
      String email,
      String password,
      ) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result =
      await _repo
          .loginWithEmail(
        email,
        password,
      );

      if (result != null) {
        user = result.user;

        await NotificationService().saveToken();

        return true;
      }

      return false;
    }catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          error = "No account found with this email";
        } else if (e.code == 'wrong-password') {
          error = "Incorrect password";
        } else if (e.code == 'invalid-email') {
          error = "Invalid email format";
        } else if (e.code == 'invalid-credential') {
          error = "Email or password is incorrect";
        } else {
          error = e.message ?? "Login failed";
        }
      } else {
        error = "Something went wrong";
      }

      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// SIGNUP
  Future<bool> signUp(
      String email,
      String password,
      String fullName,
      String city,
      String address,
      String phone,
      String profileImage,
      ) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result =
      await _repo.signUpWithEmail(
        email,
        password,
      );

      if (result != null) {
        user = result.user;

        await _repo.saveUserToFirestore(
          user!,
          fullName,
          phone,
          city,
          address,
          profileImage,
        );

        await NotificationService().saveToken();

        return true;
      }
      return false;
    } catch (e) {
      print(e);
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// FORGOT PASSWORD
  Future<bool> forgotPassword(
      String email) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _repo
          .forgotPassword(email);

      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    await _repo.logout();
    user = null;
    notifyListeners();
  }
}