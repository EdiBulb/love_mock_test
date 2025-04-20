import 'package:flutter/material.dart';
// Result Page
class ResultPage extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int highScore; // highest score.

  const ResultPage({
    // constructor.
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.highScore, // highest score
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(title: const Text("Quiz Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quiz Finished",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              "🥇 High Score: $highScore 🥇",
              style: TextStyle(fontSize: 18, color: Colors.white60),
            ),
            Text(
              "🎉 You got $correctAnswers / $totalQuestions! 🎉",
              style: TextStyle(fontSize: 24, color: Colors.amber, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
