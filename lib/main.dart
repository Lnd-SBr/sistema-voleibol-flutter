// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const Coach5x1App());
}

class Coach5x1App extends StatelessWidget {
  const Coach5x1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voley Systems',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // 👉 respeita o modo do sistema
      home: const HomeScreen(),
    );

  }
}
