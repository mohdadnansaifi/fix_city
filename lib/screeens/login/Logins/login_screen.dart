import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  bool _isLoading = false;
  final fireBaseAuth=FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static const primary50 = Color(0xFFF0FDF4);
  static const primary100 = Color(0xFFDCFCE7);
  static const primary500 = Color(0xFF22C55E);
  static const primary600 = Color(0xFF16A34A);

  Future<UserCredential?>signWithGoogle()async{
    try{

      await _googleSignIn.initialize(
        serverClientId: "451757392716-u6t6kjaap1mdmaa0sff7huajo8r00sgi.apps.googleusercontent.com",
      );

      final GoogleSignInAccount? googleUser= await _googleSignIn.authenticate();
      if(googleUser==null){
        print("Error:null");
        return null;

      }
      final GoogleSignInAuthentication googleAuth=await googleUser.authentication;

      //create a new credentail

      final OAuthCredential credential=GoogleAuthProvider.credential(
        accessToken: null,
        idToken: googleAuth.idToken,
      );
      //once signed in, return the UserCredential
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    }
    catch(e){
      print("Error:${e.toString()}");
      return null;
    }
  }
  void _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    final userCredential = await signWithGoogle();

    setState(() => _isLoading = false);

    if (userCredential != null) {
      Navigator.pushReplacementNamed(context, '/bottomNavigation');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed in as ${userCredential.user?.displayName}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in failed or cancelled')),
      );
    }
  }


  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxContentWidth = 400.0;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[700]),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      tooltip: 'Back',
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900]),
                    ),
                    SizedBox(width: 40), // placeholder to balance space
                  ],
                ),

                // Main content
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Circular icon background with Material icon
                      Center(
                        child: Lottie.asset(
                          'assets/animations/Hello.json',
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Welcome to Fix City',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Help us keep our community clean.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height:20),

                      // Google Sign-In Button
                      SizedBox(
                        width: 280, // desired width
                        height: 50, // desired height for better tappable area
                        child: SignInButton(
                          Buttons.Google,
                          text: "Sign in with Google",
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18), // custom border radius
                          ),
                          onPressed: () {
                            _handleGoogleSignIn();
                          },
                        ),
                      ),

                    ],
                  ),
                ),

                // Footer
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      children: [
                        TextSpan(text: 'By continuing, you agree to our '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primary600,
                            decoration: TextDecoration.underline,
                          ),
                          // TODO: Add gesture recognizer for link tap
                        ),
                        TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
