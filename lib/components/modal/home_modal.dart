import 'package:app_gym_yt/models/exercise.dart';
import 'package:app_gym_yt/models/feeling.dart';
import 'package:app_gym_yt/services/exercise_service.dart';
import 'package:flutter/material.dart';


showHomeModal(BuildContext context, {Exercise? exercise}) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return ExerciseForms(exercise: exercise);
    },
  );
}

class ExerciseForms extends StatefulWidget {
  final Exercise? exercise;
  const ExerciseForms({super.key, this.exercise});

  @override
  State<ExerciseForms> createState() => _ExerciseFormsState();
}

class _ExerciseFormsState extends State<ExerciseForms> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController anotationController = TextEditingController();
  TextEditingController feelingController = TextEditingController();

  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _service = ExerciseService();

  @override
  void initState() {
    super.initState();
    if (widget.exercise != null) {
      nameController.text = widget.exercise!.name;
      descriptionController.text = widget.exercise!.description;
      anotationController.text = widget.exercise!.howTo;
    }
  }


  void addNewExercise (){
    setState(() => isLoading = true);
    final id = widget.exercise == null ? DateTime.now().toString() : widget.exercise!.id;
    Exercise exercise = Exercise(
      id: id,
      name: nameController.text,
      description: descriptionController.text,
      howTo: anotationController.text,
    );

    _service.addExercise(exercise).then((value) {
      if (feelingController.text.isNotEmpty) {
        Feeling feeling = Feeling(
          id: DateTime.now().toString(),
          feeling: feelingController.text,
          date: DateTime.now().toString(),
        );
        _service.addFeelings(exercise.id, feeling);
      }
      setState(() => isLoading = false);
      Navigator.pop(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.exercise == null ? 'Adicionar Exercício' : 'Editar Exercício', style: TextStyle(fontSize: 20)),
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
              decoration: const InputDecoration(labelText: 'Nome do Exercício'),
              controller: nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo obrigatório';
                }
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Treino'),
              controller: descriptionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo obrigatório';
                }
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Passo a passo'),
              controller: anotationController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo obrigatório';
                }
              },
            ),
            Visibility(
              visible: widget.exercise == null,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Observações (opcional)'),
                    controller: feelingController,
                  ),
                ],
              ),
            ),

            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  addNewExercise();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                fixedSize: const Size(double.infinity, 50),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(widget.exercise == null ? 'Adicionar' : 'Editar'),
            ),
          ],
        ),
      ),
    );
  }
}
