import 'package:flutter/material.dart';
import '../data/repositories/profile_repository.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepository _repo =
  ProfileRepository();

  Map<String, dynamic>? userData;
  bool isLoading = false;

  Future<void> loadProfile() async {
    isLoading = true;
    notifyListeners();

    userData =
    await _repo.getUserProfile();
    print("user Data:  ${userData}");
    
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateUserProfile({
    required String name,
    required String phone,
    required String city,
    required String address,
    required String profileImage,
  }) async {
    await _repo.updateProfile(
      name: name,
      phone: phone,
      city: city,
      address: address,
      profileImage: profileImage,
    );

    await loadProfile();
  }
}