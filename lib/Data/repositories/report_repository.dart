import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/report_model.dart';

class ReportRepository {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<ReportModel>> getUserReports(String userId) {
    return _firestore
        .collection('issue_reports')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ReportModel.fromMap(doc.id, doc.data()))
        .toList());
  }

  Future<void> submitReport({
    required String userId,
    required String category,
    required String description,
    required String imageUrl, // ✅ NEW
    required double lat,
    required double lng,
    required String address,
  }) async {
    await _firestore.collection('issue_reports').add({
      'userId': userId,
      'category': category,
      'description': description,
      'imageUrl': imageUrl, // ✅ STORE IMAGE URL
      'location': {
        'latitude': lat,
        'longitude': lng,
        'address': address,
      },
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'reported',
    });
  }
}