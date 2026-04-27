import 'package:fix_city/commons/widgets/buttons/elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../routes/routes.dart';
import '../widgets/on_boarding_content.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UColors.transparent,
        centerTitle: true,
        title: const Text(
          "Fix City",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const OnboardingContent(),
              UElevatedButton(onPressed:(){
                Navigator.pushNamed(context, AppRoutes.login);
              }, child: const Text("Get Started"))
            ],
          ),
        ),
      ),
    );
  }
}