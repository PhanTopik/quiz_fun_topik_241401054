class QuizHistoryModel {
  final String quizTitle;
  final String matakuliah;
  final int totalQuestions;
  final int correctAnswers;
  final int score;
  final DateTime date;

  QuizHistoryModel({
    required this.quizTitle,
    required this.matakuliah,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.date,
  });
  
  Map<String, dynamic> toJson() => {
    'quizTitle': quizTitle,
    'matakuliah': matakuliah,
    'totalQuestions': totalQuestions,
    'correctAnswers': correctAnswers,
    'score': score,
    'date': date.toIso8601String(),
  };

  factory QuizHistoryModel.fromJson(Map<String, dynamic> json) =>
      QuizHistoryModel(
        quizTitle: json['quizTitle'],
        matakuliah: json['matakuliah'],
        totalQuestions: json['totalQuestions'],
        correctAnswers: json['correctAnswers'],
        score: json['score'],
        date: DateTime.parse(json['date']),
      );
}