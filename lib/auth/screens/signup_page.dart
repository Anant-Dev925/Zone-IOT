import 'package:flutter/material.dart';
import 'otp_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2C4A5),
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: const Text(
          "New User Registration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            // Name + Surname in same row
            Row(
              children: [
                Expanded(
                  child: _inputField(controller: nameController, label: "Name"),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _inputField(
                    controller: surnameController,
                    label: "Surname",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Address
            _inputField(controller: addressController, label: "Address"),

            const SizedBox(height: 20),

            // Email
            _inputField(controller: emailController, label: "Email"),

            const SizedBox(height: 20),

            // Phone
            _inputField(controller: phoneController, label: "Phone"),

            const SizedBox(height: 40),

            // Send OTP Button
            InkWell(
              onTap: () {
                // TODO: connect Bloc or API → send OTP to email/phone

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => OTPPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 40,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Text(
                    "Send OTP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable textfield
  Widget _inputField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
