import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LotoSimulatorApp());
}

class LotoSimulatorApp extends StatelessWidget {
  const LotoSimulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOTO Safety Simulator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF14181F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC7861B),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}