import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_providers.dart';
import '../../bottom_navigation_bar.dart';
import '../../onboarding/screens/get_started.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {

        // 🔄 Show loading
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ✅ User logged in
        if (authProvider.user != null) {
          return const BottomNavigationPage();
        }

        // ❌ Not logged in
        return const GetStartedScreen();
      },
    );
  }
}