import 'package:flutter/material.dart';
import '../widgets/auth_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            AuthButton(
              label: "Get Started",
              onTap: () {
                /// TODO: Navigate to your home/dashboard screen later.
              },
            ),
          ],
        ),
      ),
    );
  }
}
