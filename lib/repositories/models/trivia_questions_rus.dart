class TriviaQuestionRus {
  final String correctAnswer;
  final String wrongAnswer1;
  final String wrongAnswer2;
  final String wrongAnswer3;
  final String question;
  final List<String> shuffledAnswers;

  TriviaQuestionRus._(this.correctAnswer, this.question, this.wrongAnswer1,
      this.wrongAnswer2, this.wrongAnswer3)
      : shuffledAnswers = [
          correctAnswer,
          wrongAnswer1,
          wrongAnswer2,
          wrongAnswer3,
        ]..shuffle();

  factory TriviaQuestionRus.fromJson(Map<String, dynamic> json) {
    return TriviaQuestionRus._(
      json['correct_answer'] as String,
      json['question'] as String,
      json['wrong_answer_1'] as String,
      json['wrong_answer_2'] as String,
      json['wrong_answer_3'] as String,
    );
  }
}
