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
    QuizCardModel(
      id: '3',
      title: 'Dasar dasar HCI',
      matakuliah: 'Human computer interaction',
      imagePath: 'assets/images/hci.jpg',
    ),
    QuizCardModel(
      id: '4',
      title: 'Penerapan Warehouse ke Organisasi',
      matakuliah: 'Business Intelligence',
      imagePath: 'assets/images/bi.jpg',
    ),
    QuizCardModel(
      id: '5',
      title: 'Algoritma Enkripsi Plaintext',
      matakuliah: 'Kriptografi',
      imagePath: 'assets/images/kriptografi.jpg',
    ),
  ];
}