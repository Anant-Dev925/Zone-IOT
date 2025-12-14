import 'package:flutter/material.dart';
import 'auth/screens/opening_page.dart';

void main() {
  runApp(const IoTProvisioningApp());
}

class IoTProvisioningApp extends StatelessWidget {
  const IoTProvisioningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IoT Provisioning App",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Georgia',
        scaffoldBackgroundColor: const Color(0xFFD2C4A5),
        primaryColor: Colors.orange.shade700,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange.shade700,
          foregroundColor: Colors.white,
        ),
      ),

      home: const OpeningPage(), // first screen
    );
  }
}
