import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/auth/bloc/auth_bloc.dart';
import 'package:iot/auth/bloc/auth_event.dart';
import 'package:iot/auth/bloc/auth_state.dart';
import 'package:iot/auth/screens/welcome_page.dart';

class OTPPage extends StatefulWidget {
  final String? email;
  final String? phone;

  const OTPPage({super.key, this.email, this.phone});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2C4A5),
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: const Text(
          "Confirm OTP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            _showLoadingDialog();
          } else {
            Navigator.pop(context); // close loader if open
          }

          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const WelcomePage()),
            );
          }

          if (state is AuthError) {
            _showError(state.message);
          }
        },

        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // OTP textfield
                TextField(
                  controller: otpController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(letterSpacing: 5),
                  decoration: const InputDecoration(
                    labelText: "Enter OTP",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 40),

                // Verify OTP button
                InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(
                      VerifyOtp(
                        email: widget.email ?? "",
                        phone: widget.phone ?? "",
                        otp: otpController.text.trim(),
                      ),
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
                    child: const Text(
                      "Verify OTP",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
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

  // LOADING POPUP
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.orange),
        );
      },
    );
  }

  // ERROR SNACKBAR
  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red.shade700),
    );
  }
}
