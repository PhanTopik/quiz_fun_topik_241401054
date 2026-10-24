import 'package:flutter/material.dart';
import '../Models/quiz_history_model.dart';
import '../Services/quiz_history_service.dart';
import '../Widgets/app_scaffold.dart';
import '../Services/theme_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<QuizHistoryModel>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    setState(() {
      _historyFuture = QuizHistoryService.getQuizHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return AppScaffold(
      appBar: AppBar(
        title: Text('Riwayat Kuis', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: FutureBuilder<List<QuizHistoryModel>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Belum ada riwayat kuis yang dikerjakan.',
                style: TextStyle(color: textColor.withValues(alpha: 0.6), fontSize: screenWidth * 0.038),
              ),
            );
          }

          final histories = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(screenWidth * 0.04),
            itemCount: histories.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = histories[index];
              return ValueListenableBuilder<ThemeMode>(
                valueListenable: ThemeService.themeNotifier,
                builder: (context, currentThemeMode, child) {
                  final platformBrightness = MediaQuery.platformBrightnessOf(context);
                  final isDarkMode = currentThemeMode == ThemeMode.dark ||
                      (currentThemeMode == ThemeMode.system && platformBrightness == Brightness.dark);

                  return Container(
                    margin: EdgeInsets.only(bottom: screenWidth * 0.03),
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(screenWidth * 0.035),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withValues(alpha: 0.15) : Colors.black.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.quizTitle,
                                style: TextStyle(fontSize: screenWidth * 0.042, fontWeight: FontWeight.bold, color: textColor),
                              ),
                            ),
                            // Menampilkan Skor / 100
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025, vertical: screenWidth * 0.01),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              ),
                              child: Text(
                                '${item.score} / 100',
                                style: TextStyle(fontSize: screenWidth * 0.038, fontWeight: FontWeight.bold, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenWidth * 0.015),
                        Text(
                          item.matakuliah,
                          style: TextStyle(fontSize: screenWidth * 0.035, color: textColor.withValues(alpha: 0.7)),
                        ),
                        SizedBox(height: screenWidth * 0.025),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Jumlah Soal: ${item.totalQuestions}',
                              style: TextStyle(fontSize: screenWidth * 0.032, color: textColor.withValues(alpha: 0.5)),
                            ),
                            Text(
                              'Benar: ${item.correctAnswers}',
                              style: TextStyle(fontSize: screenWidth * 0.032, color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}