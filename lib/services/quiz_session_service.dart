class QuizSessionService {
  // Menyimpan jawaban pengguna berdasarkan quizId
  static final Map<String, Map<int, int>> _activeSessions = {};

  // Mengambil progres jawaban untuk kuis tertentu
  static Map<int, int> getSessionAnswers(String quizId) {
    return _activeSessions[quizId] ?? {};
  }

  // Menyimpan progres jawaban
  static void saveSessionAnswers(String quizId, Map<int, int> answers) {
    _activeSessions[quizId] = Map.from(answers);
  }

  // Menghapus sesi setelah kuis selesai
  static void clearSession(String quizId) {
    _activeSessions.remove(quizId);
  }
}