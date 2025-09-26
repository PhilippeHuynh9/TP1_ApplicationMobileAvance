import 'package:flutter/material.dart';
import 'task.dart';
import 'package:tp1_flutter/singleton.dart';
import 'accueil.dart';
import 'connexion.dart';

class Creation extends StatefulWidget {
  final Function(Task) onAdd;
  const Creation({super.key, required this.onAdd});

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _progressController =
      TextEditingController(text: '0');
  DateTime? _dateEcheance;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateEcheance ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateEcheance = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _add() {
    final title = _nomController.text.trim();
    if (title.isEmpty) return;
    int progress = int.tryParse(_progressController.text) ?? 0;
    if (progress < 0) progress = 0;
    if (progress > 100) progress = 100;
    final task = Task(
        title: title, progressPercent: progress, dueDate: _dateEcheance);
    widget.onAdd(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer une tâche")),
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
              leading: const Icon(Icons.add),
              title: const Text('Ajout de tâche'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Creation(onAdd: widget.onAdd),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                labelText: "Nom de la tâche",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _progressController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Pourcentage d'avancement (0-100)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _dateEcheance != null
                        ? 'Date d\'échéance : ${_dateEcheance!.day}/${_dateEcheance!.month}/${_dateEcheance!.year}'
                        : 'Aucune date sélectionnée',
                  ),
                ),
                OutlinedButton(
                  onPressed: _selectDate,
                  child: const Text('Entrer la date'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _add,
              child: const Text("Ajouter"),
            ),
          ],
        ),
      ),
    );
  }
}
