import 'package:flutter/material.dart';

class SnackbarUtils {
  // Fungsi utilitas global untuk menampilkan SnackBar
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}