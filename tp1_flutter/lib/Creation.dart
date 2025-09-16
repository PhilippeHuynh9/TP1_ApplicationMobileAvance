import 'package:flutter/material.dart';

class Creation extends StatefulWidget {
  const Creation({super.key});

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  final TextEditingController _nomController = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer une tâche")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(
                labelText: "Nom de la tâche",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
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
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ajouter"),
            ),
          ],
        ),
      ),
    );
  }
}
