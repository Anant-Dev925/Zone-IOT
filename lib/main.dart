import 'package:flutter/material.dart';
import 'auth/screens/opening_page.dart';

void main() {
  runApp(const IoTApp());
}

class IoTApp extends StatelessWidget {
  const IoTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Zone",
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const OpeningPage(),
    );
  }
}
