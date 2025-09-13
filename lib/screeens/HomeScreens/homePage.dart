import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FixCityHomeScreen extends StatelessWidget {
  static const primaryColor = Color(0xFF11D452);
  static const secondaryColor = Color(0xFF4ADE80);
  static const backgroundColor = Color(0xFFF0FDF4);
  static const textPrimary = Color(0xFF1F2937);
  static const textSecondary = Color(0xFF4B5563);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Fix City',
                          style: TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: textPrimary,
                            size: 28,
                          ),
                          onPressed: () {
                            // TODO: add settings action
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Background illustration (with opacity)
                    Lottie.asset(
                      'assets/animations/Eco-friendly city.json',
                      width: 300,
                      height: 300,
                      fit: BoxFit.fill,
                    ),


                    const SizedBox(height: 32),

                    // Welcome Text
                    Text(
                      'Welcome back ',
                      style: TextStyle(
                        color: textPrimary,
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
                        color: textSecondary,
                        fontSize: 16,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    // Button
                    Card(
                      elevation: 10,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/createReport');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(
                              0xFF11D452,
                            ), // solid green color
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            elevation: 4,
                            shadowColor: Colors.greenAccent.withOpacity(0.3),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            'Find an Issue? Create Report',
                            style: TextStyle(letterSpacing: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
