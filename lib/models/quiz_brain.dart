import 'question.dart';

class QuizBrain {
  final List<Question> _questionBank;
  int _questionNumber = 0;
  int _correctCount = 0;

  QuizBrain(this._questionBank);

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() => _questionBank[_questionNumber].questionText;
  bool getQuestionAnswer() => _questionBank[_questionNumber].questionAnswer;
  int get correctCount => _correctCount;
  int get totalQuestions => _questionBank.length;
  bool isFinished() => _questionNumber >= _questionBank.length - 1;
  void incrementScore() => _correctCount++;
  void reset() {
    _questionNumber = 0;
    _correctCount = 0;
  }

  int get highScore => _correctCount; // 현재 점수와 같게 임시 반환

}