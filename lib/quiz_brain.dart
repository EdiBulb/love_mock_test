import 'package:quizzler_flutter_app/question.dart';
import 'package:shared_preferences/shared_preferences.dart';


class QuizBrain { // class name should start with capital letter.

  int _questionNumber=0; // private property

  int _correctCount = 0;
  int _highScore = 0;

  List<Question> _questionBank = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];


  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1){
      _questionNumber++;
    }
    print(_questionNumber);
    print(_questionBank.length);
  }

  // getter
  String getQuestionText(){
    return _questionBank[_questionNumber].questionText;
  }
  // getter
  bool getQuestionAnswer(){
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  int get totalQuestions => _questionBank.length;

  // return score getter
  int get correctCount => _correctCount;

  // To increase score
  void incrementScore() {
    _correctCount++;
  }

  // 초기 실행 시 최고 점수 불러오기
  int get highScore => _highScore;
  // what is Future, async, await, getInstance()?
  Future<void> loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt('highScore') ?? 0;
  }

  // 점수 저장
  // what is Future, async, await, getInstance()?
  Future<void> saveHighScoreIfNeeded() async {
    if (_correctCount > _highScore) {
      _highScore = _correctCount;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('highScore', _highScore);
    }
  }

  void reset() {
    _questionNumber = 0;
    _correctCount = 0; // score reset.
  }
}