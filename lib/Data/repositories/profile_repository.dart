import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = _auth.currentUser;

    if (user == null) return null;
    print("Current User UID: ${user.uid}");

    final doc = await _firestore
        .collection("users")
        .doc(user.uid)
        .get();
    print("Firestore Data: ${doc.data()}");
    return doc.data();
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String city,
    required String address,
    required String profileImage,

  }) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .update({
      "name": name,
      "phone": phone,
      "city": city,
      "address": address,
      "profileImage": profileImage,
    });
  }
}

