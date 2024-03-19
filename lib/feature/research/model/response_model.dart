import 'dart:convert';

import 'package:custom_research/feature/research/model/answer_model.dart';
import 'package:flutter/foundation.dart';

class ResponseModel {
  final String question;
  final List<String> descriptiveAnswer;
  final List<String> responses;
  ResponseModel({
    required this.question,
    required this.descriptiveAnswer,
    required this.responses,
  });

  ResponseModel copyWith({
    String? question,
    List<String>? descriptiveAnswer,
    List<String>? responses,
  }) {
    return ResponseModel(
      question: question ?? this.question,
      descriptiveAnswer: descriptiveAnswer ?? this.descriptiveAnswer,
      responses: responses ?? this.responses,
    );
  }

  Map<String, dynamic> toMap() {
    final descriptiveListAnswers = descriptiveAnswer.indexed
        .map((e) => '${responses[e.$1]} - ${e.$2}')
        .toList();
    return {
      'question': question,
      'descriptiveAnswer': descriptiveListAnswers,
      'responses': responses,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      question: map['question'] ?? '',
      descriptiveAnswer: List<String>.from(map['descriptiveAnswer']),
      responses: List<String>.from(map['responses']),
    );
  }

  factory ResponseModel.fromAnswer(AnswerModel answer) {
    return ResponseModel(
      question: answer.question,
      descriptiveAnswer: answer.descriptiveAnswer != null
          ? ["${answer.descriptiveAnswer}"]
          : [],
      responses: answer.options,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResponseModel(question: $question, descriptiveAnswer: $descriptiveAnswer, responses: $responses)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseModel &&
        other.question == question &&
        listEquals(other.descriptiveAnswer, descriptiveAnswer) &&
        listEquals(other.responses, responses);
  }

  @override
  int get hashCode =>
      question.hashCode ^ descriptiveAnswer.hashCode ^ responses.hashCode;
}
