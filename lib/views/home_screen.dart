import 'package:app_gym_yt/components/home_modal.dart';
import 'package:app_gym_yt/models/exercise.dart';
import 'package:app_gym_yt/views/exercise_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  final List<Exercise> listExercise = [
    Exercise(id: "ex01", name: "Supino Inclinado", description: "Treino A", howTo: "1. Deite no banco inclinado\n2. Segure a barra com as mãos afastadas\n3. Levante a barra até esticar os braços\n4. Abaixe a barra até tocar o peito\n5. Repita 3 séries de 10 repetições"),
    Exercise(id: "ex02", name: "Supino Reto", description: "Treino B", howTo: "1. Deite no banco reto\n2. Segure a barra com as mãos afastadas\n3. Levante a barra até esticar os braços\n4. Abaixe a barra até tocar o peito\n5. Repita 3 séries de 10 repetições"),
    Exercise(id: "ex03", name: "Supino Declinado", description: "Treino C", howTo: "1. Deite no banco declinado\n2. Segure a barra com as mãos afastadas\n3. Levante a barra até esticar os braços\n4. Abaixe a barra até tocar o peito\n5. Repita 3 séries de 10 repetições"),
    Exercise(id: "ex04", name: "Rosca Direta", description: "Treino D", howTo: "1. Segure a barra com as mãos afastadas\n2. Levante a barra até esticar os braços\n3. Abaixe a barra até tocar o peito\n4. Repita 3 séries de 10 repetições"),
    Exercise(id: "ex05", name: "Rosca Alternada", description: "Treino E", howTo: "1. Segure a barra com as mãos afastadas\n2. Levante a barra até esticar os braços\n3. Abaixe a barra até tocar o peito\n4. Repita 3 séries de 10 repetições"),
    Exercise(id: "ex06", name: "Rosca Martelo", description: "Treino F", howTo: "1. Segure a barra com as mãos afastadas\n2. Levante a barra até esticar os braços\n3. Abaixe a barra até tocar o peito\n4. Repita 3 séries de 10 repetições"),
    Exercise(id: "ex07", name: "Tríceps Pulley", description: "Treino G", howTo: "1. Segure a barra com as mãos afastadas\n2. Levante a barra até esticar os braços\n3. Abaixe a barra até tocar o peito\n4. Repita 3 séries de 10 repetições"),
    Exercise(id: "ex08", name: "Tríceps Testa", description: "Treino H", howTo: "1. Segure a barra com as mãos afastadas\n2. Levante a barra até esticar os braços\n3. Abaixe a barra até tocar o peito\n4. Repita 3 séries de 10 repetições"),
    Exercise(id: "ex09", name: "Tríceps Francês", description: "Treino I", howTo: "1. Segure a barra com as mãos afastadas\n2. Levante a barra até esticar os braços\n3. Abaixe a barra até tocar o peito\n4. Repita 3 séries de 10 repetições"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user!.displayName!),
              accountEmail: Text(user!.email!),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              // currentAccountPicture: CircleAvatar(
              //   backgroundImage: NetworkImage(user!.photoURL!),
              // ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            const Spacer(),
            ListTile(
              title: const Text('Sair'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/auth');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Home'),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showHomeModal(context);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: listExercise.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listExercise[index].name),
            subtitle: Text(listExercise[index].description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(exercise: listExercise[index]),
                ),
              );
            },
          );
        },
      ),
    );

  }
}
