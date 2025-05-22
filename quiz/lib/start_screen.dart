import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 40.0,
        children: [
          Image.asset("assets/images/quiz-logo.png", width: 300),
          const Text(
            "Learn Flutter the fun way!",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            child: const Text(
              "Start Quiz",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
