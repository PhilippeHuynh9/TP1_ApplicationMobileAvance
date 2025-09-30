import 'package:flutter/material.dart';
import 'package:tp1_flutter/consultaion.dart';
import 'package:tp1_flutter/singleton.dart';
import 'package:tp1_flutter/transfert.dart';
import 'creation.dart';
import 'connexion.dart';
import 'task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [];

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Accueil")),
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
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Ajout de tâche'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Creation(onAdd: addTask),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              onTap: () async {
                Navigator.pop(context); // ferme le drawer
                await deconnexionAPI(); // appelle l'API pour déconnexion
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Connexion()),
                );
              },
            ),

          ],
        ),
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('Aucune tâche.'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final t = tasks[index];
                final dueText = t.dueDate != null
                    ? '${t.dueDate!.day}/${t.dueDate!.month}/${t.dueDate!.year}'
                    : '—';
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(t.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        LinearProgressIndicator(value: t.progressPercent / 100.0),
                        const SizedBox(height: 8),
                        Text('Avancement: ${t.progressPercent}%   •   Temps écoulé: ${t.percentTimeElapsed()}%'),
                      ],
                    ),
                    trailing: Text(dueText),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Consultaion(task: t)),
                      );
                      // Rafraîchir la liste après retour (au cas où la tâche a été modifiée)
                      setState(() {});
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Creation(onAdd: addTask),
            ),
          );
        },
        tooltip: "Créer une tâche",
        child: const Icon(Icons.add),
      ),
    );
  }
}
