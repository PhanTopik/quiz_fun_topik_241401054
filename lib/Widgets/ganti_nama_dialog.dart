import 'package:flutter/material.dart';
import '../Services/user_service.dart';

Future<void> gantiNamaDialog({
  required BuildContext context,
  required String currentName,
  required Function(String) onNameUpdated,
}) async {
  // Controller untuk mengelola input teks pada TextField dengan nilai awal nama saat ini
  final TextEditingController nameController = TextEditingController(text: currentName);

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // Judul dialog
        title: const Text('Ganti Nama'),
        // Input teks untuk memasukkan nama baru akun
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Nama Lengkap Baru',
          ),
        ),
        actions: [
          // Tombol Batal
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          // Tombol Simpan nama akun
          ElevatedButton(
            onPressed: () async {
              final newName = nameController.text.trim();
              if (newName.isNotEmpty) {
                await UserService.updateName(newName);
                onNameUpdated(newName);

                if (context.mounted) {
                  Navigator.pop(context);
                  // Menampilkan notifikasi sukses menganti nama akun
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