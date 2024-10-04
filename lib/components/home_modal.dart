import 'package:flutter/material.dart';

showHomeModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return ExerciseForms();
    },
  );
}

class ExerciseForms extends StatefulWidget {
  const ExerciseForms({super.key});

  @override
  State<ExerciseForms> createState() => _ExerciseFormsState();
}

class _ExerciseFormsState extends State<ExerciseForms> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController anotationController = TextEditingController();
  TextEditingController feelingController = TextEditingController();

  bool isLoading = false;




  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(20),
      child: Form(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Adicionar Exercício', style: TextStyle(fontSize: 20)),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome'),
              controller: nameController,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Descrição'),
              controller: descriptionController,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Anotações'),
              controller: anotationController,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Como se sentiu?'),
              controller: feelingController,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                fixedSize: const Size(double.infinity, 50),
                minimumSize: const Size(double.infinity, 50),

              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
