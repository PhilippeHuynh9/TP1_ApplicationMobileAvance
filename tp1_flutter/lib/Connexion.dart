import 'package:flutter/material.dart';
import 'package:tp1_flutter/Inscription.dart';

import 'HomeScreen.dart';

class Connexion  extends StatelessWidget {
  const Connexion({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inscription")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Nom d'utilisateur",
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mot de passe",
              ),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Inscription()),
                );
              },
              child: const Text("Inscription"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text("Connexion"),
            ),
          ],

        ),
      ),
    );
  }
}
