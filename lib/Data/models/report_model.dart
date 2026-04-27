import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id;
  final String userId;
  final String category;
  final String description;
  final String imageUrl;
  final String status;
  final DateTime? timestamp;
  final String address;
  final double latitude;
  final double longitude;

  ReportModel({
    required this.id,
    required this.userId,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.timestamp,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  /// 🔹 Convert Firestore → Model
  factory ReportModel.fromMap(String id, Map<String, dynamic> data) {
    final location = data['location'] ?? {};

    return ReportModel(
      id: id,
      userId: data['userId'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      status: data['status'] ?? 'reported',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
      address: location['address'] ?? '',
      latitude: (location['latitude'] ?? 0).toDouble(),
      longitude: (location['longitude'] ?? 0).toDouble(),
    );
  }

  /// 🔹 Convert Model → Firestore (optional but useful)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'status': status,
      'timestamp': timestamp,
      'location': {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      },
    };
  }
}