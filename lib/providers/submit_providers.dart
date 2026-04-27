import 'dart:io';

import 'package:flutter/material.dart';

import '../Data/repositories/report_repository.dart';
import '../core/services/cloudinary_service.dart';

class SubmitProvider with ChangeNotifier {
  final ReportRepository _repo = ReportRepository();
  final CloudinaryService _cloudinary = CloudinaryService();

  bool isLoading = false;

  Future<void> submitReport({
    required BuildContext context,
    required String userId,
    required String category,
    required String description,
    required File imageFile,
    required double lat,
    required double lng,
    required String address,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      /// 🔥 STEP 1: Upload to Cloudinary
      final imageUrl = await _cloudinary.uploadImage(imageFile);

      /// 🔥 STEP 2: Save to Firestore
      await _repo.submitReport(
        userId: userId,
        category: category,
        description: description,
        imageUrl: imageUrl,
        lat: lat,
        lng: lng,
        address: address,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Report Submitted")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}