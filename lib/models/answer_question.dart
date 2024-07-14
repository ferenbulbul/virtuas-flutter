class AnswerAndQuestion {
  String? questionTitle;
  String? answerTitle;

  AnswerAndQuestion({this.questionTitle, this.answerTitle});

  factory AnswerAndQuestion.fromJson(Map<String, dynamic> json) {
    return AnswerAndQuestion(
      questionTitle: json['questionTitle'],
      answerTitle: json['answerTitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionTitle': questionTitle,
      'answerTitle': answerTitle,
    };
  }
}
