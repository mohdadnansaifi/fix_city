import 'package:firebase_auth/firebase_auth.dart';

import '../../core/services/firebase_auth_services.dart';

class AuthRepository {
  final FirebaseAuthService _service =
  FirebaseAuthService();

  /// Google login
  Future<UserCredential?>
  signInWithGoogle() {
    return _service
        .signInWithGoogle();
  }


  /// Email login
  Future<UserCredential?>
  loginWithEmail(
      String email,
      String password,
      ) {
    return _service
        .loginWithEmail(
      email,
      password,
    );
  }

  Future<void> saveUserToFirestore(
      User user,
      String name,
      String phone,
      String city,
      String address,
      String profileImage,
      ) {
    return _service.saveUserToFirestore(
      user,
      name,
      phone,
      city,
      address,
      profileImage
    );
  }

  /// Signup
  Future<UserCredential?>
  signUpWithEmail(
      String email,
      String password,
      ) {
    return _service
        .signUpWithEmail(
      email,
      password,
    );
  }

  /// Forgot password
  Future<void> forgotPassword(
      String email) {
    return _service
        .resetPassword(email);
  }

  /// Logout
  Future<void> logout() {
    return _service.logout();
  }
}