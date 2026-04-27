import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> saveToken() async {
    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return;

    String? token =
    await _messaging.getToken();

    print("FCM TOKEN: $token");

    if (token != null) {
      await _firestore
          .collection("users")
          .doc(user.uid)
          .update({
        "fcmToken": token,
      });
    }
  }
}