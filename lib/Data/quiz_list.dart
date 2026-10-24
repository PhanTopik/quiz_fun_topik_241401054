import '../Models/quiz_card_model.dart';

class QuizData {
  static final List<QuizCardModel> initialQuizzes = [
    QuizCardModel(
      id: '1',
      title: 'Bahasa Flutter',
      matakuliah: 'Pemrograman Mobile',
      imagePath: 'assets/images/flutter.jpg',
    ),
    QuizCardModel(
      id: '2',
      title: 'Soal UTS KPT',
      matakuliah: 'Komputasi Paralel & Terdistribusi',
      imagePath: 'assets/images/kpt.jpg',
    ),
  ];
}