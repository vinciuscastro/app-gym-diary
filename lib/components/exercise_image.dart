import 'dart:io';
import 'package:app_gym_yt/models/exercise.dart';
import 'package:app_gym_yt/services/exercise_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ExerciseImage extends StatefulWidget {
  final Exercise exercise;

  const ExerciseImage({super.key, required this.exercise});

  @override
  State<ExerciseImage> createState() => _ExerciseImageState();
}

class _ExerciseImageState extends State<ExerciseImage> {
  XFile? _imageFile;

  final ExerciseService _service = ExerciseService();

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
    await picker.pickImage(source: source, imageQuality: 50);

    if (selectedImage != null) {
      setState(() {
        _imageFile = selectedImage; // Atualiza _imageFile com a imagem selecionada
        widget.exercise.image = selectedImage.path; // Atualiza a imagem do exercício
      });
      await _service.uploadImage(widget.exercise.id, _imageFile!); // Aguarda o upload da imagem
    }
  }

  void showImageModal(BuildContext context, String exerciseId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: const Text('Câmera',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
              TextButton(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: const Text('Galeria',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),
      height: 250,
      child: Stack(
        children: [
          Center(
            child: _imageFile == null
                ? (widget.exercise.image == null
                ? const Icon(Icons.image_not_supported, size: 30)
                : Image.network(widget.exercise.image!))
                : Image.file(File(_imageFile!.path)),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: IconButton(
              onPressed: () {
                showImageModal(context, widget.exercise.id);
              },
              icon: const Icon(Icons.add_a_photo),
            ),
          ),
        ],
      ),
    );
  }
}
