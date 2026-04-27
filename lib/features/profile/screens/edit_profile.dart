import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../commons/widgets/buttons/elevated_button.dart';
import '../../../providers/profile_provider.dart';
import '../../../core/services/cloudinary_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  File? selectedImage;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = context.read<ProfileProvider>();
      await provider.loadProfile();

      final data = provider.userData;

      if (data != null) {
        nameController.text = data['name'] ?? '';
        phoneController.text = data['phone'] ?? '';
        cityController.text = data['city'] ?? '';
        addressController.text = data['address'] ?? '';
      }
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() {
        isSaving = true;
      });

      final provider = context.read<ProfileProvider>();

      // Keep old image if user doesn't pick new one
      String imageUrl =
          provider.userData?['profileImage'] ?? '';

      if (selectedImage != null) {
        imageUrl = await CloudinaryService()
            .uploadImage(selectedImage!);
      }

      await provider.updateUserProfile(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        city: cityController.text.trim(),
        address: addressController.text.trim(),
        profileImage: imageUrl,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile Updated Successfully"),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$label is required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final profileImage = provider.userData?['profileImage'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : profileImage.isNotEmpty
                          ? NetworkImage(profileImage)
                      as ImageProvider
                          : null,
                      child: selectedImage == null &&
                          profileImage.isEmpty
                          ? const Icon(
                        Icons.person,
                        size: 50,
                      )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              buildTextField(
                controller: nameController,
                label: "Full Name",
                icon: Icons.person,
              ),

              const SizedBox(height: 16),

              buildTextField(
                controller: phoneController,
                label: "Phone Number",
                icon: Icons.phone,
              ),

              const SizedBox(height: 16),

              buildTextField(
                controller: cityController,
                label: "City",
                icon: Icons.location_city,
              ),

              const SizedBox(height: 16),

              buildTextField(
                controller: addressController,
                label: "Address",
                icon: Icons.home,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: UElevatedButton(

                  onPressed: () async {
                    if (!isSaving) {
                      await saveProfile();
                    }
                  },
                  child: isSaving
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text("Save Changes"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}