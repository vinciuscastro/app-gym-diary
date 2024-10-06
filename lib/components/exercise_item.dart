import 'package:app_gym_yt/components/home_modal.dart';
import 'package:app_gym_yt/models/exercise.dart';
import 'package:app_gym_yt/services/exercise_service.dart';
import 'package:app_gym_yt/views/exercise_screen.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  final Exercise exercise;
  final ExerciseService service;
  const ExerciseItem({super.key , required this.exercise, required this.service});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(exercise.id),
      onDismissed: (direction) {
        service.deleteExercise(exercise.id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete),
      ),
      confirmDismiss: (_) async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Atenção'),
              content: const Text('Deseja realmente excluir o exercício?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Não'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Sim'),
                ),
              ],
            );
          },
        );
      },
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        color: Colors.grey[200],
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(exercise.name),
          subtitle: Text(exercise.description),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showHomeModal(context, exercise: exercise);
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ExerciseScreen(exercise: exercise),
              ),
            );
          },
        ),
      ),
    );
  }
}


