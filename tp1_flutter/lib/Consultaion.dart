import 'package:flutter/material.dart';
import 'package:tp1_flutter/singleton.dart';
import 'accueil.dart';
import 'connexion.dart';
import 'Creation.dart';

class Consultaion extends StatelessWidget {
  const Consultaion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consultation")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(UserSession().username),
              accountEmail: null,
              currentAccountPicture: const Icon(Icons.person),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('Ajout de tâche'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Creation(onAdd: (task, date) {}),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Connexion()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(child: Text("Bienvenue sur la page de consultation")),
    );
  }
}
