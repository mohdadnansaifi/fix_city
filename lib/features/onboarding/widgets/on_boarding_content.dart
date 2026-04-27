import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/unnamed.png'),
            height: 250,
          ),
          SizedBox(height: 20),

          Text(
            "Make Your City Better",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "Spot an issue? Report it in seconds...",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}