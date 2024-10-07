import 'package:app_gym_yt/components/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:app_gym_yt/models/feeling.dart';
import 'package:app_gym_yt/services/feeling_service.dart';

showFeelingModal(BuildContext context, String exerciseId, {Feeling? feeling}) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FeelingForms(exerciseId: exerciseId, feeling: feeling);
    },
  );
}

class FeelingForms extends StatefulWidget {
  final String exerciseId;
  final Feeling? feeling;
  const FeelingForms({super.key, required this.exerciseId, this.feeling});

  @override
  State<FeelingForms> createState() => _FeelingFormsState();
}

class _FeelingFormsState extends State<FeelingForms> {
  TextEditingController obsController = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _service = FeelingService();

  @override
  void initState() {
    super.initState();
    if (widget.feeling != null) {
      obsController.text = widget.feeling!.feeling;
    }
  }

  void sendFeeling() {
    setState(() => isLoading = true);
    final id = widget.feeling == null ? DateTime.now().toString() : widget.feeling!.id;
    Feeling feeling = Feeling(
      id: id,
      feeling: obsController.text,
      date: DateTime.now().toString(),
    );

    _service.addFeeling(widget.exerciseId, feeling).then((value) {
      customSnackBar(context: context, message: 'Observação salva com sucesso', error: false);
      setState(() => isLoading = false);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.feeling == null ? 'Adicionar Observação' : 'Editar Observação',
                    style: const TextStyle(fontSize: 20),
                  ),
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
                decoration: const InputDecoration(labelText: 'Nova Observação'),
                controller: obsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    sendFeeling();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                  fixedSize: const Size(double.infinity, 50),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
