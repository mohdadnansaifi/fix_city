import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/routes.dart';

class HomeHeaderWithAnimation extends StatelessWidget {
  const HomeHeaderWithAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Fix City',
                  style: Theme.of(context).textTheme.headlineMedium
              ),
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.notification,
                  );
                },
              )
            ],
          ),

          Lottie.asset(
            'assets/animations/Eco-friendly city.json',
            width: 300,
            height: 300,
            fit: BoxFit.fill,
          ),
        ],
        ),
    );
  }
}