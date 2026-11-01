import 'package:flutter/material.dart';
import '../Models/quiz_history_model.dart';
import '../Services/quiz_history_service.dart';
import '../Widgets/app_scaffold.dart';
import '../Widgets/history_card_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with WidgetsBindingObserver {
  List<QuizHistoryModel> _histories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    QuizHistoryService.historyChangeNotifier.addListener(_loadHistory);
    _loadHistory();
  }

  @override
  void dispose() {
    QuizHistoryService.historyChangeNotifier.removeListener(_loadHistory);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Membersihkan riwayat kuis saat aplikasi dijeda atau ditutup
    if (state == AppLifecycleState.detached || state == AppLifecycleState.paused) {
      _clearHistoryData();
    }
  }

  // Fungsi asinkron untuk menghapus data riwayat kuis
  Future<void> _clearHistoryData() async {
    await QuizHistoryService.clearHistory();
  }

  // Fungsi asinkron untuk memuat daftar riwayat kuis dari penyimpanan lokal
  Future<void> _loadHistory() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    final data = await QuizHistoryService.getQuizHistory();

    if (!mounted) return;
    setState(() {
      _histories = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Kuis',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.06,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Menampilkan indikator loading jika data sedang dimuat
          : _histories.isEmpty
          ? Center(
        // Tampilan jika data riwayat masih kosong
        child: Text(
          'Belum ada riwayat kuis yang dikerjakan.',
          style: TextStyle(
            color: textColor.withValues(alpha: 0.6),
            fontSize: screenWidth * 0.038,
          ),
        ),
      )
      // Menampilkan daftar riwayat menggunakan ListView.builder
          : ListView.builder(
        padding: EdgeInsets.all(screenWidth * 0.04),
        itemCount: _histories.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = _histories[index];
          return HistoryCardWidget(item: item);
        },
      ),
    );
  }
}