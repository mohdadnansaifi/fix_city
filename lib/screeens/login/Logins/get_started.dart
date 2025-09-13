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
                      Ink.image(image: AssetImage('assets/unnamed.png'),height: 300,width: 300,),
                      SizedBox(height: 20),
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
                      SizedBox(height: 10),
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
              Card(
                elevation: 15,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textPrimary,
                    padding:
                    EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    // elevation: 8,
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
