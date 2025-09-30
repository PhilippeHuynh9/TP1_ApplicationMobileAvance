import 'package:flutter/material.dart';
import 'package:tp1_flutter/inscription.dart';
import 'package:tp1_flutter/singleton.dart';
import 'package:tp1_flutter/transfert.dart';
import 'accueil.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitConnexion() async {
    final req = RequeteConnexion(
      username: _usernameController.text.trim(),
      password: _passwordController.text,
    );

    try {
      final rep = await connexionAPI(req);
      print("Réponse serveur : ${rep.message}");

      if (rep.message.toLowerCase().contains('success') || rep.username != null) {
        UserSession().username = rep.username ?? req.username;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : ${rep.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ce compte n’existe pas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Nom d'utilisateur",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
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
              onPressed: _submitConnexion,
              child: const Text("Connexion"),
            ),
          ],
        ),
      ),
    );
  }
}
