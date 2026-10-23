import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Config/routes.dart';
import '../Data/quiz_list.dart';
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

  final List _quizList = QuizData.initialQuizzes;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          'Course Overview',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.055,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(screenWidth * 0.04),
        itemCount: _quizList.length,
        itemBuilder: (context, index) {
          final quiz = _quizList[index];
          return QuizCardWidget(
            title: quiz.title,
            matakuliah: quiz.matakuliah,
            imagePath: quiz.imagePath,
            progress: quiz.progress,
            onTap: () {
              context.push(AppRoutes.quizDetail(quiz.id));
            },
          );
        },
      ),
    );
  }
}