import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CreateReportProvider with ChangeNotifier {
  File? image;
  Position? position;
  String address = ""; // ✅ NEW
  bool isLoading = false;
  String? error;

  final ImagePicker _picker = ImagePicker();

  /// 📷 Pick Image
  Future<void> pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source);

      if (picked != null) {
        image = File(picked.path);
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  /// 📍 Get Location + Address
  Future<void> getLocation() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      /// Check service
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        error = "Enable location services";
        return;
      }

      /// Check permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        error = "Location permission denied";
        return;
      }

      /// Get position
      final pos = await Geolocator.getCurrentPosition();
      position = pos;

      /// 🔥 Get Address (NEW)
      final placemarks =
      await placemarkFromCoordinates(pos.latitude, pos.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        address =
        "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }

    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ❌ Remove Image
  void removeImage() {
    image = null;
    notifyListeners();
  }
}