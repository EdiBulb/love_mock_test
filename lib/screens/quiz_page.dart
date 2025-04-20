import 'package:flutter/material.dart';
import '../models/quiz_brain.dart';
import '../models/question.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  final String guestName;
  final List<Question> questions;

  const QuizPage({super.key, required this.guestName, required this.questions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuizBrain quizBrain;
  List<Icon> scoreKeeper = [];

  @override
  void initState() {
    super.initState();
    quizBrain = QuizBrain(widget.questions);
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        quizBrain.incrementScore();
        scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      }

      if (quizBrain.isFinished()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              guestName: widget.guestName,
              correctAnswers: quizBrain.correctCount,
              totalQuestions: quizBrain.totalQuestions,
              highScore: quizBrain.highScore, //

            ),
          ),
        );
        quizBrain.reset();
        scoreKeeper.clear();
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    style: const TextStyle(fontSize: 24.0, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ...[true, false].map((answer) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: answer ? Colors.green : Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => checkAnswer(answer),
                    child: Text(answer ? 'True' : 'False',
                        style: const TextStyle(fontSize: 20.0)),
                  ),
                ),
              )),
              Row(children: scoreKeeper),
            ],
          ),
        ),
      ),
    );
  }
}
