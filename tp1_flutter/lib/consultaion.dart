import 'package:flutter/material.dart';
import 'package:tp1_flutter/singleton.dart';
import 'accueil.dart';
import 'connexion.dart';
import 'creation.dart';
import 'task.dart';

class Consultaion extends StatefulWidget {
  final Task task;
  const Consultaion({super.key, required this.task});

  @override
  State<Consultaion> createState() => _ConsultaionState();
}

class _ConsultaionState extends State<Consultaion> {
  late int _progress;

  @override
  void initState() {
    super.initState();
    _progress = widget.task.progressPercent;
  }

  void _updateProgress(int value) {
    setState(() {
      _progress = value.clamp(0, 100);
      widget.task.progressPercent = _progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dueText = widget.task.dueDate != null
        ? '${widget.task.dueDate!.day}/${widget.task.dueDate!.month}/${widget.task.dueDate!.year}'
        : 'Aucune';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultation"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Revenir à la page précédente
          },
        ),
      ),
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
                    builder: (context) => Creation(onAdd: (Task t) {}),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.task.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: _progress / 100.0),
            const SizedBox(height: 8),
            Text('Avancement: ${_progress}%'),
            const SizedBox(height: 8),
            Text('Temps écoulé: ${widget.task.percentTimeElapsed()}%'),
            const SizedBox(height: 12),
            Text('Date limite: $dueText'),
            const SizedBox(height: 8),
            Text('Créée le: ${widget.task.createdAt.day}/${widget.task.createdAt.month}/${widget.task.createdAt.year}'),
            const SizedBox(height: 20),
            const Text('Modifier l\'avancement :'),
            Slider(
              value: _progress.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              label: '$_progress%',
              onChanged: (v) => _updateProgress(v.round()),
              onChangeEnd: (v) {
                final pct = v.round();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Avancement mis à jour : $pct%')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
