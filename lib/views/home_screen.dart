import 'package:app_gym_yt/components/app_drawer.dart';
import 'package:app_gym_yt/components/exercise_item.dart';
import 'package:app_gym_yt/components/home_modal.dart';
import 'package:app_gym_yt/models/exercise.dart';
import 'package:app_gym_yt/services/exercise_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _service = ExerciseService();
  User? user = FirebaseAuth.instance.currentUser;
  bool isDesc = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(user: user!),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            onPressed: () {
              setState(() => isDesc = !isDesc);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showHomeModal(context);
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: _service.getExercises(isDesc: isDesc),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Nenhum exercício cadastrado'),
              );
            } else {
              final exercises = snapshot.data as List<Exercise>;
              return Container(
                margin: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return ExerciseItem(exercise: exercises[index], service: _service);
                  },
                ),
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao buscar os exercícios'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
