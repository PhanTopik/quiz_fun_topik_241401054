import '../Data/soal.dart';

class QuizCardModel {
  final String id;
  final String title;
  final String matakuliah;
  final String imagePath;
  final double progress;

  QuizCardModel({
    required this.id,
    required this.title,
    required this.matakuliah,
    required this.imagePath,
    required this.progress,
  });

  int get totalQuestions => SoalData.getSoalByQuizId(id).length;
}