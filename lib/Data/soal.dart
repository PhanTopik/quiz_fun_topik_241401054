import '../Models/question_model.dart';

class SoalData {
  // List soal quiz bahasa flutter
  static final List<QuestionModel> flutterQuizQuestions = [
    QuestionModel(
      questionText: 'Apakah widget utama untuk membangun struktur dasar visual dalam Flutter?',
      options: ['Scaffold', 'Container', 'Column', 'SizedBox'],
      correctOptionIndex: 0, // Scaffold
    ),
    QuestionModel(
      questionText: 'Bahasa pemrograman apa yang digunakan oleh framework Flutter?',
      options: ['Python', 'Dart', 'Java', 'C++'],
      correctOptionIndex: 1, // Dart
    ),
    QuestionModel(
      questionText: 'Widget apa yang digunakan untuk membuat tampilan list yang dapat di-scroll secara efisien?',
      options: ['Column', 'Row', 'ListView.builder', 'Container'],
      correctOptionIndex: 2, // ListView.builder
    ),
  ];

  // List pertanyaan soal UTS KPT
  static final List<QuestionModel> kptQuizQuestions = [
    QuestionModel(
      questionText: 'Apa singkatan dari KPT dalam konteks ilmu komputer?',
      options: [
        'Komputasi Paralel dan Terdistribusi',
        'Keamanan Pemrograman Terstruktur',
        'Koneksi Protokol Telegram',
        'Kompilasi Perangkat Terpadu'
      ],
      correctOptionIndex: 0, // Komputasi Paralel dan Terdistribusi
    ),
  ];

  /// Fungsi helper untuk mengambil daftar soal berdasarkan quizId
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