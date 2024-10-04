import 'package:flutter/material.dart';

customSnackBar({required BuildContext context, required String message, bool Error = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Error ? Colors.red : Colors.green,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      )
    ),
  );
}