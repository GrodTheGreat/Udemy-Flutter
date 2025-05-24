import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  final List<String> chosenAnswers;
  final void Function() restartQuiz;

  const ResultsScreen(
    this.restartQuiz, {
    super.key,
    required this.chosenAnswers,
  });

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        "question_index": i,
        "question": questions[i].text,
        "correct_answer": questions[i].answers[0],
        "user_answer": chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions =
        summaryData.where((summary) {
          return summary['correct_answer'] == summary['user_answer'];
        }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!",
              style: const TextStyle(
                color: Color.fromARGB(150, 255, 255, 255),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30.0),
            QuestionsSummary(summaryData),
            const SizedBox(height: 30.0),
            TextButton.icon(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: const Icon(Icons.replay),
              ),
              label: const Text("Restart Quiz!"),
            ),
          ],
        ),
      ),
    );
  }
}
