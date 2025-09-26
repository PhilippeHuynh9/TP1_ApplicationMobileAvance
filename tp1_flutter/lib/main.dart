import 'package:flutter/material.dart';
import 'package:tp1_flutter/connexion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Connexion(),
    );
  }
}