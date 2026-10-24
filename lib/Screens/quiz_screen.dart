import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Data/quiz_list.dart';
import '../Data/soal.dart';
import '../Models/question_model.dart';
import '../Models/quiz_history_model.dart';
import '../Services/quiz_history_service.dart';
import '../Widgets/app_scaffold.dart';

class QuizScreen extends StatefulWidget {
  final String quizId;
  final String quizTitle;

  const QuizScreen({
    super.key,
    required this.quizId,
    required this.quizTitle,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<QuestionModel> _questions;

  int _currentIndex = 0;
  int? _selectedAnswerIndex;

  final Map<int, int> _userAnswers = {};

  @override
  void initState() {
    super.initState();
    _questions = SoalData.getSoalByQuizId(widget.quizId);
  }

  void _answerQuestion(int selectedIndex) {
    setState(() {
      _selectedAnswerIndex = selectedIndex;
      _userAnswers[_currentIndex] = selectedIndex; // Simpan jawaban pengguna
    });
  }

  void _nextQuestion() {
    if (_selectedAnswerIndex == null) return;

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswerIndex = _userAnswers[_currentIndex];
      });
    } else {
      _showResultScreen();
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _selectedAnswerIndex = _userAnswers[_currentIndex];
      });
    }
  }

  int _calculateCorrectCount() {
    int correctCount = 0;
    _userAnswers.forEach((index, selectedAnswer) {
      if (selectedAnswer == _questions[index].correctOptionIndex) {
        correctCount++;
      }
    });
    return correctCount;
  }

  Future<void> _showResultScreen() async {
    final int correctCount = _calculateCorrectCount();
    final int totalScore = _questions.isNotEmpty
        ? ((correctCount / _questions.length) * 100).toInt()
        : 0;

    final textColor = Theme.of(context).colorScheme.onSurface;

    final currentQuizCard = QuizData.initialQuizzes.firstWhere(
          (q) => q.id == widget.quizId,
      orElse: () => QuizData.initialQuizzes.first,
    );

    await QuizHistoryService.saveQuizHistory(
      QuizHistoryModel(
        quizTitle: widget.quizTitle,
        matakuliah: currentQuizCard.matakuliah,
        totalQuestions: _questions.length,
        correctAnswers: correctCount,
        score: totalScore,
        date: DateTime.now(),
      ),
    );

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Hasil Kuis', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber, size: 60),
            const SizedBox(height: 16),
            Text('Total Skor Anda', style: TextStyle(fontSize: 16, color: textColor.withValues(alpha: 0.7))),
            const SizedBox(height: 8),
            Text('$totalScore / 100', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 12),
            Text('Benar $correctCount dari ${_questions.length} soal.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: textColor)),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.pop(context);
                context.pop();
              },
              child: const Text('Selesai & Kembali'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textColor = Theme.of(context).colorScheme.onSurface;
    if (_questions.isEmpty) {
      return AppScaffold(
        appBar: AppBar(
          title: Text(widget.quizTitle, style: TextStyle(color: textColor)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: textColor),
        ),
        body: Center(
          child: Text('Soal tidak ditemukan untuk kuis ini.', style: TextStyle(color: textColor)),
        ),
      );
    }

    final currentQuestion = _questions[_currentIndex];

    return AppScaffold(
      appBar: AppBar(
        title: Text(widget.quizTitle, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Soal ${_currentIndex + 1} dari ${_questions.length}',
                  style: TextStyle(fontSize: 14, color: textColor.withValues(alpha: 0.6)),
                ),
                if (_currentIndex > 0)
                  TextButton.icon(
                    onPressed: _previousQuestion,
                    icon: const Icon(Icons.arrow_back, size: 16),
                    label: const Text('Sebelumnya'),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Pertanyaan
            Text(
              currentQuestion.questionText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 24),

            // Pilihan Opsi Jawaban
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.options.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedAnswerIndex == index;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey.shade400,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected ? Colors.green.withValues(alpha: 0.1) : Colors.transparent,
                    ),
                    child: RadioListTile<int>(
                      title: Text(currentQuestion.options[index], style: TextStyle(color: textColor)),
                      value: index,
                      groupValue: _selectedAnswerIndex,
                      onChanged: (value) {
                        if (value != null) _answerQuestion(value);
                      },
                    ),
                  );
                },
              ),
            ),

            // Tombol Selanjutnya / Lihat Skor Akhir
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedAnswerIndex != null ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  _currentIndex == _questions.length - 1 ? 'Lihat Skor Akhir' : 'Selanjutnya',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}