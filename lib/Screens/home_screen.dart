import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Config/routes.dart';
import '../Data/quiz_list.dart';
import '../Models/quiz_card_model.dart';
import '../Widgets/quiz_card_widget.dart';
import '../Widgets/app_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _searchController = TextEditingController();
  List<QuizCardModel> _filteredQuizList = [];

  @override
  void initState() {
    super.initState();
    _filteredQuizList = QuizData.initialQuizzes;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterQuizzes(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredQuizList = QuizData.initialQuizzes;
      } else {
        _filteredQuizList = QuizData.initialQuizzes.where((quiz) {
          return quiz.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Quiz',
          style: TextStyle(
            color: textColor,
            fontFamily: "Baloo2",
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.055,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Widget Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.01,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterQuizzes,
              decoration: InputDecoration(
                hintText: 'Ketik Judul Quiz',
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor.withValues(alpha: 0.6),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: textColor.withValues(alpha: 0.6),
                  ),
                  onPressed: () {
                    _searchController.clear();
                    _filterQuizzes('');
                  },
                )
                    : null,
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.015,
                  horizontal: screenWidth * 0.04,
                ),
              ),
              style: TextStyle(
                fontSize: screenWidth * 0.038,
                color: textColor,
              ),
            ),
          ),

          Expanded(
            child: _filteredQuizList.isEmpty
                ? Center(
              child: Text(
                'Kuiz tidak ditemukan',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: textColor.withValues(alpha: 0.6),
                ),
              ),
            )
                : GridView.builder(
              padding: EdgeInsets.all(screenWidth * 0.04),
              itemCount: _filteredQuizList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: screenWidth * 0.03,
                mainAxisSpacing: screenWidth * 0.03,
                childAspectRatio: 0.78,
              ),
              itemBuilder: (context, index) {
                final quiz = _filteredQuizList[index];
                return QuizCardWidget(
                  title: quiz.title,
                  matakuliah: quiz.matakuliah,
                  imagePath: quiz.imagePath,
                  totalQuestions: quiz.totalQuestions,
                  onTap: () {
                    context.push(AppRoutes.quizDetail(quiz.id), extra: quiz);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}