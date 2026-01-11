import 'package:flutter/material.dart';
import 'screens/splash.dart';

void main() {
  runApp(const BusMateApp());
}

class BusMateApp extends StatelessWidget {
  const BusMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BusMate',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Splash(), // 👈 App starts here
    );
  }
}
