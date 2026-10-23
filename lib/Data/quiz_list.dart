import '../Models/quiz_card_model.dart';

class QuizData {
  static final List<QuizCardModel> initialQuizzes = [
    QuizCardModel(
      id: '1',
      title: 'Bahasa Flutter',
      matakuliah: 'Pemograman mobile',
      imagePath: 'assets/images/profile.jpg',
      progress: 0.33,
    ),
    QuizCardModel(
      id: '2',
      title: 'Soal UTS KPT',
      matakuliah: 'Komputasi paralel dan terdistribusi',
      imagePath: 'assets/images/profile.jpg',
      progress: 0.75,
    ),
  ];
}