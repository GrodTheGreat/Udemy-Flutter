import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  final List<Map<String, Object>> summaryData;

  const QuestionsSummary(this.summaryData, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      child: SingleChildScrollView(
        child: Column(
          children:
              summaryData.map((summary) {
                return Row(
                  children: [
                    Text(((summary['question_index'] as int) + 1).toString()),
                    Expanded(
                      child: Column(
                        children: [
                          Text(summary['question'] as String),
                          const SizedBox(height: 5.0),
                          Text(summary['user_answer'] as String),
                          Text(summary['correct_answer'] as String),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
