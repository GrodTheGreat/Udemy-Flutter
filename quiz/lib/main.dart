import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(50.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple, Colors.purple],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 40.0,
              children: [
                Image.asset("assets/images/quiz-logo.png", width: 280),
                Text(
                  "Learn Flutter the fun way!",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                TextButton(
                  onPressed: () {},
                  // style: ButtonStyle(),
                  child: Text(
                    "Start Quiz",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
