
import 'package:app_gym_yt/models/exercise.dart';
import 'package:app_gym_yt/models/feeling.dart';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  final Exercise exercise = Exercise(
    id: '1',
    name: 'Supino Inclinado',
    description: 'Treino A',
    howTo: '1. Deite no banco inclinado\n2. Segure a barra com as mãos afastadas\n3. Levante a barra até esticar os braços\n4. Abaixe a barra até tocar o peito\n5. Repita 3 séries de 10 repetições',
  );

  final List<Feeling> feelings = [
    Feeling(id: '1', feeling: 'Muito bem', date: '2022-01-01'),
    Feeling(id: '2', feeling: 'Bem', date: '2022-01-02'),
    Feeling(id: '3', feeling: 'Mal', date: '2022-01-03'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exercise.name),
            Text(exercise.description, style: const TextStyle(fontSize: 14)),
          ],
        ),
        toolbarHeight: 70
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              height: 250,
              child: TextButton(
                onPressed: () {},
                child: const Text('Imagem'),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Como fazer?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(exercise.howTo),
            const SizedBox(height: 20),
            const Divider(color: Colors.black),
            const SizedBox(height: 20),
            const Text('Como estou me sentindo?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: feelings.map((feeling) {
                return ListTile(
                  title: Text(feeling.feeling),
                  subtitle: Text(feeling.date),
                  contentPadding: const EdgeInsets.all(0),
                  leading: Icon(Icons.double_arrow_rounded),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
