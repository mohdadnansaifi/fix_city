import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Stream<QuerySnapshot> getNotifications() {
    final uid =
        FirebaseAuth.instance.currentUser!.uid;
    print(FirebaseAuth.instance.currentUser!.uid);
    return _firestore
        .collection("notifications")
        .where(
      "userId",
      isEqualTo: uid,
    )
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots();
  }
}