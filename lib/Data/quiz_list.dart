import 'package:quiz_fun_topik/Data/soal.dart';

import '../Models/quiz_card_model.dart';

class QuizData {
  static final List<QuizCardModel> initialQuizzes = [
    QuizCardModel(
      id: '1',
      title: 'Bahasa Flutter',
      matakuliah: 'Pemrograman Mobile',
      imagePath: 'assets/images/flutter.png',
      progress: 0.0,
    ),
    QuizCardModel(
      id: '2',
      title: 'Soal UTS KPT',
      matakuliah: 'Komputasi Paralel & Terdistribusi',
      imagePath: 'assets/images/kpt.png',
      progress: 0.0,
    ),
  ];
}