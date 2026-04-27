import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn =
      GoogleSignIn.instance;

  /// GOOGLE LOGIN
  Future<UserCredential?>
  signInWithGoogle() async {
    await _googleSignIn.initialize(
      serverClientId:
      "451757392716-u6t6kjaap1mdmaa0sff7huajo8r00sgi.apps.googleusercontent.com",
    );

    final GoogleSignInAccount?
    googleUser =
    await _googleSignIn
        .authenticate();

    if (googleUser == null) {
      return null;
    }

    final googleAuth =
    await googleUser
        .authentication;

    final credential =
    GoogleAuthProvider
        .credential(
      idToken:
      googleAuth.idToken,
    );

    return await _auth
        .signInWithCredential(
        credential);
  }

  Future<void> saveUserToFirestore(
      User user,
      String name,
      String phone,
      String city,
      String address,
      String profileImage
      ) async {
    await _firestore
        .collection("users")
        .doc(user.uid)
        .set({
      "uid": user.uid,
      "name": name,
      "email": user.email,
      "phone": phone,
      "city": city,
      "address": address,
      "profileImage": profileImage,
      "createdAt":
      FieldValue.serverTimestamp(),
    });
  }

  /// EMAIL SIGN UP
  Future<UserCredential?>
  signUpWithEmail(
      String email,
      String password,
      ) async {
    return await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// EMAIL LOGIN
  Future<UserCredential?>
  loginWithEmail(
      String email,
      String password,
      ) async {
    return await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// FORGOT PASSWORD
  Future<void> resetPassword(
      String email) async {
    await _auth
        .sendPasswordResetEmail(
      email: email,
    );
  }

  /// LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  /// CURRENT USER
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}