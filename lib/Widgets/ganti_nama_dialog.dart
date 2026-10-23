import 'package:flutter/material.dart';
import '../Services/user_service.dart';

Future<void> gantiNamaDialog({
  required BuildContext context,
  required String currentName,
  required Function(String) onNameUpdated,
}) async {
  final TextEditingController nameController = TextEditingController(text: currentName);

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Ganti Nama'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Nama Lengkap Baru',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newName = nameController.text.trim();
              if (newName.isNotEmpty) {
                // fungsi update nama
                await UserService.updateName(newName);
                onNameUpdated(newName);

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nama berhasil diperbarui!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    },
  );
}