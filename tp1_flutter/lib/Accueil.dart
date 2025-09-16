import 'package:flutter/material.dart';
import 'package:tp1_flutter/Consultaion.dart';

import 'Creation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Accueil")),
      body: const Center(child: Text("Bienvenue sur l'accueil")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Creation()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: "Créer une tâche",
      ),
    );
  }
}

