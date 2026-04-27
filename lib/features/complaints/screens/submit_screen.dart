import 'dart:io';

import 'package:fix_city/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_providers.dart';
import '../../../providers/submit_providers.dart';

class SubmitScreen extends StatefulWidget {
  final String photoPath;
  final double latitude;
  final double longitude;
  final String  address;

  const SubmitScreen({
    super.key,
    required this.address,
    required this.photoPath,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCategory;
  final TextEditingController descriptionController =
  TextEditingController();

  final categories = [
    'Pothole',
    'Water Logging',
    'Garbage',
    'Street Light',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final submitProvider = context.watch<SubmitProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Issue Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              /// CATEGORY
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
                    .toList(),
                onChanged: (val) => setState(() => selectedCategory = val),
                validator: (val) =>
                val == null ? "Select category" : null,
              ),

              const SizedBox(height: 20),

              /// DESCRIPTION
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "Describe issue",
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                val!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 30),
             ///submit button
              ElevatedButton(
                onPressed: submitProvider.isLoading
                    ? null
                    : () async {
                  if (!_formKey.currentState!.validate()) return;

                  await context
                      .read<SubmitProvider>()
                      .submitReport(
                    context: context,
                    userId: auth.user!.uid, // FIXED
                    category: selectedCategory!,
                    imageFile: File(widget.photoPath),
                    description:
                    descriptionController.text,
                    lat: widget.latitude,
                    lng: widget.longitude,
                    address: widget.address,
                  );

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.bottomNav,
                        (route) => false,
                  );
                },
                child: submitProvider.isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}