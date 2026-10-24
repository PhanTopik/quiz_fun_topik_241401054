import '../Models/question_model.dart';

class SoalData {
  static final List<QuestionModel> flutterQuizQuestions = [
    QuestionModel(
      questionText: 'Apakah widget utama untuk membangun struktur dasar visual dalam Flutter?',
      options: ['Scaffold', 'Container', 'Column', 'SizedBox'],
      correctOptionIndex: 0,
    ),
    QuestionModel(
      questionText: 'Bahasa pemrograman apa yang digunakan oleh framework Flutter?',
      options: ['Python', 'Dart', 'Java', 'C++'],
      correctOptionIndex: 1,
    ),
    QuestionModel(
      questionText: 'Widget apa yang digunakan untuk membuat tampilan list yang dapat di-scroll secara efisien?',
      options: ['Column', 'Row', 'ListView.builder', 'Container'],
      correctOptionIndex: 2,
    ),
  ];

  static final List<QuestionModel> kptQuizQuestions = [
    QuestionModel(
      questionText: 'Apa singkatan dari KPT dalam konteks ilmu komputer?',
      options: [
        'Komputasi Paralel dan Terdistribusi',
        'Keamanan Pemrograman Terstruktur',
        'Koneksi Protokol Telegram',
        'Kompilasi Perangkat Terpadu'
      ],
      correctOptionIndex: 0,
    ),
  ];

  static List<QuestionModel> getSoalByQuizId(String quizId) {
    switch (quizId) {
      case '1':
        return flutterQuizQuestions;
      case '2':
        return kptQuizQuestions;
      default:
        return [];
    }
  }
}