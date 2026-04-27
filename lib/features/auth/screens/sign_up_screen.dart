import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../commons/widgets/buttons/elevated_button.dart';
import '../../../providers/auth_providers.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/cloudinary_service.dart';
import '../../../routes/routes.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  File? selectedImage;


  final  TextEditingController emailController = TextEditingController();

  final  TextEditingController passwordController = TextEditingController();

  final  TextEditingController nameController = TextEditingController();

  final  TextEditingController phoneController = TextEditingController();

  final  TextEditingController cityController = TextEditingController();

  final  TextEditingController addressController = TextEditingController();

  String imageUrl = "";

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final picked =
    await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        selectedImage =
            File(picked.path);
      });
    }
  }@override
  Widget build(BuildContext context) {
    final provider= Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              const Text(
                "Create Account",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  selectedImage != null
                      ? FileImage(
                    selectedImage!,
                  )
                      : null,
                  child: selectedImage == null
                      ? const Icon(
                    Icons.camera_alt,
                    size: 30,
                  )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: UElevatedButton(
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Fill all fields"),
                        ),
                      );
                      return;
                    }

                    if (selectedImage != null) {
                      imageUrl = await CloudinaryService()
                          .uploadImage(selectedImage!);
                    }

                    final success = await provider.signUp(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      nameController.text.trim(),
                      cityController.text.trim(),
                      addressController.text.trim(),
                      phoneController.text.trim(),
                      imageUrl,
                    );

                    if (success) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.bottomNav,
                            (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            provider.error ?? "Signup failed",
                          ),
                        ),
                      );
                    }
                  },
                  child: provider.isLoading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text("Create Account"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
