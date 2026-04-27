import 'package:flutter/material.dart';

class WelcomeAndSubtitle extends StatelessWidget {
  const WelcomeAndSubtitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome back ',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        // Subtitle
        Text(
          "Let's make our city a better place, one report at a time.",
          style: TextStyle(
            fontSize: 16,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}