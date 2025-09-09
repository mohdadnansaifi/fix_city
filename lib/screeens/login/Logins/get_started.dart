import 'package:flutter/material.dart';

class getStartedpage extends StatefulWidget {
  @override
  _getStartedpageState createState() => _getStartedpageState();
}

class _getStartedpageState extends State<getStartedpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  final Color textPrimary = Color(0xFF1A2E23);
  final Color backgroundColor = Color(0xFFF8FCF9);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive aspect ratio (like aspect-square in Tailwind)
    final double imageSize = screenWidth * 0.9;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeTransition(
                        opacity: _opacityAnimation,
                        child: Container(
                          width: imageSize,
                          height: imageSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCuOfTHbt3fQSQLrj1Y4I74ITYZCKUZhtB22lafifwPB0giBd20RTe7hWb42sIEuKw7sJAHCIA6PfLOuWcsjVMxic5gW9k-DWoA0WzqUkBgNwWF7F5zmDKZTzsP1Sa9FkPdAr3NUXlESsQbLvCyFQw5MW8xfG7Pl68NnQOAOV-mkk0r76yceHjernZb_RRjHVTIJDdevgu3iDzchqajuXPDEmz_mgsRjEt5vWbsjHBalJlDulxcOv4MPD8eZzfaoZZ2VQ8Z4NmLM24'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Make Your City Better",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.7,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Spot an issue? Report it in seconds. From potholes to broken streetlights, your reports help us take action.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textPrimary.withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textPrimary,
                    padding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    elevation: 8,
                  ),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
