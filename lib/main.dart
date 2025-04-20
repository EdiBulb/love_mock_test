import 'package:flutter/material.dart';

import 'quiz_brain.dart';
import 'screens/result_page.dart';

// create quizBrain object.
QuizBrain quizBrain = QuizBrain();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // SharedPreferences 로드 전에 필요!
  await quizBrain.loadHighScore(); // 앱 시작 시 최고 점수 불러오기
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade700,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) async {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    // ✅ 정답 여부 먼저 체크하고 점수 처리
    if (userPickedAnswer == correctAnswer) {
      scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      quizBrain.incrementScore();
    } else {
      scoreKeeper.add(Icon(Icons.close, color: Colors.red));
    }

    // ✅ 점수 저장 (최고 점수 갱신 가능성 있음)
    await quizBrain.saveHighScoreIfNeeded();

    setState(() {
      if (quizBrain.isFinished()) {
        int correctCount = quizBrain.correctCount;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              totalQuestions: quizBrain.totalQuestions,
              correctAnswers: correctCount,
              highScore: quizBrain.highScore,
            ),
          ),
        );

        quizBrain.reset();
        scoreKeeper = [];
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text('True', style: TextStyle(fontSize: 20.0)),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(children: scoreKeeper),
      ],
    );
  }
}
