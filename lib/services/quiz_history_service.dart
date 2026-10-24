import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/quiz_history_model.dart';

class QuizHistoryService {
  static const String _keyHistory = 'quiz_history_list';

  static final ValueNotifier<int> historyChangeNotifier = ValueNotifier<int>(0);

  // Menyimpan hasil kuis baru ke local storage
  static Future<void> saveQuizHistory(QuizHistoryModel history) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existingList = prefs.getStringList(_keyHistory) ?? [];

    existingList.add(jsonEncode(history.toJson()));
    await prefs.setStringList(_keyHistory, existingList);
    historyChangeNotifier.value++;
  }

  // Mengambil daftar riwayat kuis
  static Future<List<QuizHistoryModel>> getQuizHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existingList = prefs.getStringList(_keyHistory) ?? [];

    return existingList
        .map((item) => QuizHistoryModel.fromJson(jsonDecode(item)))
        .toList()
        .reversed
        .toList();
  }

  // Menghapus seluruh data riwayat kuis
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHistory);

    historyChangeNotifier.value++;
  }
}