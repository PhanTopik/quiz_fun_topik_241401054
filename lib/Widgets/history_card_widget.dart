import 'package:flutter/material.dart';
import '../Models/quiz_history_model.dart';
import '../Services/theme_service.dart';

class HistoryCardWidget extends StatelessWidget {
  final QuizHistoryModel item;
  const HistoryCardWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService.themeNotifier,
      builder: (context, currentThemeMode, child) {
        final platformBrightness = MediaQuery.platformBrightnessOf(context);
        final isDarkMode = currentThemeMode == ThemeMode.dark ||
            (currentThemeMode == ThemeMode.system && platformBrightness == Brightness.dark);

        final containerBg = isDarkMode
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.03);

        final borderColor = isDarkMode
            ? Colors.white.withValues(alpha: 0.15)
            : Colors.black.withValues(alpha: 0.08);

        return Container(
          margin: EdgeInsets.only(bottom: screenWidth * 0.03),
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: containerBg,
            borderRadius: BorderRadius.circular(screenWidth * 0.035),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul kuis dan kotak skor
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.quizTitle,
                      style: TextStyle(
                        fontSize: screenWidth * 0.042,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                      vertical: screenWidth * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                    child: Text(
                      '${item.score} / 100',
                      style: TextStyle(
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.015),
              // Nama mata kuliah
              Text(
                item.matakuliah,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: textColor.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: screenWidth * 0.025),
              // Jumlah soal dan jawaban benar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jumlah Soal: ${item.totalQuestions}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.032,
                      color: textColor.withValues(alpha: 0.5),
                    ),
                  ),
                  Text(
                    'Benar: ${item.correctAnswers}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.032,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}