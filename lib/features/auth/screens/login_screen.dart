// import 'package:fix_city/core/constants/size.dart';
// import 'package:flutter/material.dart';
// import '../widgets/animations_and_text.dart';
// import '../widgets/google_button.dart';
// import '../widgets/login_footer.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   static const primary600 = Color(0xFF16A34A);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ///Animation and welcome
//               HelloAnimationWelcomeText(),
//
//               const SizedBox(height: USizes.spaceBtwSections),
//
//               ///Google button
//               GoogleButton(),
//               SizedBox(height: USizes.spaceBtwSections),
//               /// terms and conditions
//               LoginFooter(primary600: primary600),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:fix_city/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:fix_city/features/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../commons/widgets/buttons/elevated_button.dart';
import '../../../providers/auth_providers.dart';
import '../../../routes/routes.dart';
import '../widgets/google_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final providr= Provider.of<AuthProvider>(context);
    return Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  /// Logo
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      // color: const Color(0xFF16A34A),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Image.asset('assets/logo/logo.png')
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Login to continue reporting civic issues",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// Form Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [

                        /// Email Field
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Enter email",
                            prefixIcon:
                            const Icon(Icons.email_outlined),
                            filled: true,
                            // fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Password
                        TextField(
                          controller: passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: "Enter password",
                            prefixIcon:
                            const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                            filled: true,
                            // fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child:
                            const Text("Forgot Password?"),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: UElevatedButton(
                            onPressed: providr.isLoading
                                ? null
                                : () async {
                              final success =
                              await providr
                                  .loginWithEmail(
                                emailController.text
                                    .trim(),
                                passwordController.text
                                    .trim(),
                              );

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Login Successful"),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );

                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.bottomNav,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      providr.error ?? "Invalid email or password",
                                    ),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                            child: providr.isLoading
                                ? const SizedBox(
                              height: 22,
                              width: 22,
                              child:
                              CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : const Text("Login"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Divider
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                            horizontal: 10),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const GoogleButton(),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color(0xFF16A34A),
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}