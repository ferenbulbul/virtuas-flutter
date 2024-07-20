class PossibleClientPreDataResponse {
  final List<PossibleClientPreData> preDataList;

  PossibleClientPreDataResponse({
    required this.preDataList,
  });

  // Factory method to create an instance from JSON
  factory PossibleClientPreDataResponse.fromJson(Map<String, dynamic> json) {
    return PossibleClientPreDataResponse(
      preDataList: List<PossibleClientPreData>.from(
        json['preDataList'].map((item) => PossibleClientPreData.fromJson(item)),
      ),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'preDataList': preDataList.map((item) => item.toJson()).toList(),
    };
  }
}

class PossibleClientPreData {
  final int applicationId;
  final int userId;
  final String categoryTitle;
  final String userName;
  final String userSurname;
  final List<AnswerAndQuestion> answers;
  final int cost;

  PossibleClientPreData({
    required this.applicationId,
    required this.userId,
    required this.categoryTitle,
    required this.userName,
    required this.userSurname,
    required this.answers,
    required this.cost
  });

  // Factory method to create an instance from JSON
  factory PossibleClientPreData.fromJson(Map<String, dynamic> json) {
    return PossibleClientPreData(
      applicationId: json['applicationId'],
      userId: json['userId'],
      categoryTitle: json['categoryTitle'],
      userName: json['userName'],
      userSurname: json['userSurname'],
      cost: json['cost'],
      answers: List<AnswerAndQuestion>.from(
        json['answers'].map((item) => AnswerAndQuestion.fromJson(item)),
      ),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'applicationId': applicationId,
      'userId': userId,
      'categoryTitle': categoryTitle,
      'userName': userName,
      'userSurname': userSurname,
      'cost' : cost,
      'answers': answers.map((item) => item.toJson()).toList(),
    };
  }
}

class AnswerAndQuestion {
  final String question;
  final String answer;

  AnswerAndQuestion({
    required this.question,
    required this.answer,
  });

  // Factory method to create an instance from JSON
  factory AnswerAndQuestion.fromJson(Map<String, dynamic> json) {
    return AnswerAndQuestion(
      question: json['questionTitle'],
      answer: json['answerTitle'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'questionTitle': question,
      'answerTitle': answer,
    };
  }
}
