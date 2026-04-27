import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_providers.dart';
import '../../../routes/routes.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return SizedBox(
          width: 280,
          height: 50,
          child: SignInButton(
            Buttons.Google,
            text: authProvider.isLoading
                ? "Signing in..."
                : "Sign in with Google",
            onPressed: authProvider.isLoading
                ? null
                : () async {
              final success = await context
                  .read<AuthProvider>()
                  .loginWithGoogle();

              if (success) {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.bottomNav,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      authProvider.error ?? "Login Failed",
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}