import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  final List<Map<String, Object>> summaryData;

  const QuestionsSummary(this.summaryData, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      child: SingleChildScrollView(
        child: Column(
          children:
              summaryData.map((summary) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12.0),
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color:
                            summary['user_answer'] == summary["correct_answer"]
                                ? const Color.fromARGB(255, 150, 198, 241)
                                : const Color.fromARGB(255, 249, 133, 241),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        ((summary['question_index'] as int) + 1).toString(),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            summary['question'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            summary['user_answer'] as String,
                            style: const TextStyle(
                              color: Color.fromARGB(100, 255, 255, 255),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            summary['correct_answer'] as String,
                            style: const TextStyle(
                              color: Color.fromARGB(191, 124, 252, 155),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
