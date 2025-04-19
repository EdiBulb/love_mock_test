//Made Question class(which includes question, answer properties, and put it in List.
class Question { // class name should start with capital letter.

  late String questionText;
  late bool questionAnswer;

  //constructor
  Question(this.questionText, this.questionAnswer); // with this constructor, you can reduce code a lot.
  // Question( String q,  bool a){
  //   questionText = q;
  //   questionAnswer = a;
  // }
}