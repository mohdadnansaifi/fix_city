import 'package:flutter/material.dart';

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
      body: SafeArea(
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
                        icon: Icon(Icons.settings, color: textPrimary, size: 28),
                        onPressed: () {
                          // TODO: add settings action
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Background illustration (with opacity)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: 0.1,
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDIvg6cy_6rNJbLc5MTds0sjdYko_m4o1fdMKHjZzGmPI-xPZqwjSS7ee4GuaesXCTxU39V6eHZydZR48K5afE48GZSMx4YUqyocLfjy09OZt4cQSpxwCJKLih3-ZVa-ikM5T8tGs4917n-SA-ho3SIs7lyvwfp43ZxlEqFF-5IKJvq0FxgCGCjF4s-wL0SD-aQlS6GBa8LnHyNgxD8_nogu8PLMYzsMQvdijtAOffRqEUDzFw9_NqqqA9u-M6oaK-ZtbvnviNflng',
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBfAiZeAwmLapgvSEzwNG7MZ-uj_z_-2h0FZvfpaROHbut7X74t-Y67KwSLmZs67EOr_WjsPxIuaLCt2jo5I3EQdW5w00TDgDzfn59yaOLMuHEJAqjJbv07PGOd_LhpX1gg2jsJMvDw-CSVXbvCgW6RfPcsMYdllLAmfGeloC8mdNMKAhK7ox91T6Ni4ox8u4ZeVhsmMkfffbE5rupY_U2Qp9Zmk3rBEd1LcYnMAKKnWrchDEX-turxg_O5AvLDAWGYJF33TMZCvUw',
                          height: 180,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Welcome Text
                    Text(
                      'Welcome back to Fix City',
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/createReport');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF11D452), // solid green color
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

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
