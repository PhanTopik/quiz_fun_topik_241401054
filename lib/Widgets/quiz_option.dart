import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  final String optionText;
  final int index;
  final int? selectedAnswerIndex;
  final ValueChanged<int?> onChanged;

  const QuizOption({
    super.key,
    required this.optionText,
    required this.index,
    required this.selectedAnswerIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah opsi ini sedang dipilih oleh pengguna
    final isSelected = selectedAnswerIndex == index;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        // Memberikan border hijau tebal jika dipilih, atau abu-abu jika tidak
        border: Border.all(
          color: isSelected ? Colors.green : Colors.grey.shade400,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Colors.green.withValues(alpha: 0.1) : Colors.transparent,
      ),
      // Komponen radio list tile untuk interaksi pemilihan jawaban
      child: RadioListTile<int>(
        title: Text(
          optionText,
          style: TextStyle(color: textColor),
        ),
        value: index,
        groupValue: selectedAnswerIndex,
        onChanged: onChanged,
        activeColor: Colors.green,
      ),
    );
  }
}