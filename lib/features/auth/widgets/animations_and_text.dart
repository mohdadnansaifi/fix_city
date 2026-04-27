import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/size.dart';

class HelloAnimationWelcomeText extends StatelessWidget {
  const HelloAnimationWelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Lottie.asset(
            'assets/animations/Hello.json',
            width: 300,
            height: 300,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: USizes.spaceBtwSections,),
        Text(
          'Welcome to Fix City',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}