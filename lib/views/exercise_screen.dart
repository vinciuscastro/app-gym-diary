import 'package:app_gym_yt/components/exercise_image.dart';
import 'package:app_gym_yt/components/feeling_modal.dart';
import 'package:app_gym_yt/models/exercise.dart';
import 'package:app_gym_yt/services/auth_service.dart';
import 'package:app_gym_yt/services/feeling_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExerciseScreen extends StatelessWidget {
  final Exercise exercise;
  ExerciseScreen({super.key, required this.exercise});

  final _service = FeelingService();


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
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                AuthService().logout();
                Navigator.pushReplacementNamed(context, '/auth');
              },
            ),
          ],
          toolbarHeight: 70),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFeelingModal(context, exercise.id);
        },
        child: const Icon(Icons.add),
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
            ExerciseImage(exercise: exercise),
            const SizedBox(height: 20),
            const Text("Como fazer?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(exercise.howTo),
            const SizedBox(height: 20),
            const Divider(color: Colors.black),
            const SizedBox(height: 20),
            const Text('Como estou me sentindo?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            StreamBuilder(stream: _service.getFeelings(exercise.id), builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final feelings = snapshot.data!;
              if (feelings.isEmpty) {
                return const Column(
                  children: [
                    SizedBox(height: 20),
                    Text('Nenhuma observação cadastrada!', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 20),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: feelings.map((feeling) {
                  return ListTile(
                    title: Text(feeling.feeling),
                    subtitle: Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(feeling.date))),
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(Icons.double_arrow_rounded),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showFeelingModal(context, exercise.id, feeling: feeling);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {

                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),

          ],
        ),
      ),
    );
  }
}
