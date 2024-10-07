import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword, confirmPassword, isRequired;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.confirmPassword = false,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (!isRequired) return null;
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        } else if (isPassword && value.length < 6) {
          return 'Senha deve ter no mínimo 6 caracteres';
        } else if (confirmPassword && value != controller.text) {
          return 'Senhas não conferem';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      obscureText: isPassword,
    );
  }
}
