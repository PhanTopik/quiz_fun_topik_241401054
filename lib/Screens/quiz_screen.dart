import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Data/quiz_list.dart';
import '../Data/soal.dart';
import '../Models/question_model.dart';
import '../Models/quiz_history_model.dart';
import '../Services/quiz_history_service.dart';
import '../Services/quiz_session_service.dart';
import '../Widgets/app_scaffold.dart';
import '../Widgets/quiz_option.dart';

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
  late Map<int, int> _userAnswers;

  @override
  void initState() {
    super.initState();
    // Memuat daftar soal berdasarkan ID kuis
    _questions = SoalData.getSoalByQuizId(widget.quizId);

    // Memulihkan sesi jawaban pengguna yang tersimpan sebelumnya jika ada
    _userAnswers = Map.from(QuizSessionService.getSessionAnswers(widget.quizId));

    if (_userAnswers.containsKey(_currentIndex)) {
      _selectedAnswerIndex = _userAnswers[_currentIndex];
    }
  }

  // Fungsi untuk menyimpan pilihan jawaban pengguna pada soal aktif
  void _answerQuestion(int selectedIndex) {
    setState(() {
      _selectedAnswerIndex = selectedIndex;
      _userAnswers[_currentIndex] = selectedIndex;

      // Menyimpan progres jawaban ke sesi lokal secara real-time
      QuizSessionService.saveSessionAnswers(widget.quizId, _userAnswers);
    });
  }

  // Fungsi untuk berpindah ke soal berikutnya atau menampilkan hasil jika sudah soal terakhir
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

  // Fungsi untuk kembali ke soal sebelumnya
  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _selectedAnswerIndex = _userAnswers[_currentIndex];
      });
    }
  }

  // Menghitung total jawaban yang benar
  int _calculateCorrectCount() {
    int correctCount = 0;
    _userAnswers.forEach((index, selectedAnswer) {
      if (index < _questions.length && selectedAnswer == _questions[index].correctOptionIndex) {
        correctCount++;
      }
    });
    return correctCount;
  }

  // Menampilkan dialog hasil akhir, menyimpan riwayat, dan menghapus sesi kuis
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

    // Menyimpan riwayat pengerjaan kuis
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

    // Menghapus sesi kuis yang sedang aktif karena sudah selesai
    QuizSessionService.clearSession(widget.quizId);

    if (!mounted) return;

    // Menampilkan skor akhir
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
            // nomor soal dan tombol kembali ke soal sebelumnya
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

            // Teks Pertanyaan
            Text(
              currentQuestion.questionText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 24),

            // Daftar Opsi Jawaban
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.options.length,
                itemBuilder: (context, index) {
                  return QuizOption(
                    optionText: currentQuestion.options[index],
                    index: index,
                    selectedAnswerIndex: _selectedAnswerIndex,
                    onChanged: (value) {
                      if (value != null) _answerQuestion(value);
                    },
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