import 'dart:convert';

import 'package:flutter/foundation.dart';

class AnswerModel {
  final String question;
  final List<String> options;
  final String? descriptiveAnswer;
  AnswerModel({
    required this.question,
    required this.options,
    this.descriptiveAnswer,
  });

  AnswerModel copyWith({
    String? question,
    List<String>? options,
    String? descriptiveAnswer,
  }) {
    return AnswerModel(
      question: question ?? this.question,
      options: options ?? this.options,
      descriptiveAnswer: descriptiveAnswer ?? this.descriptiveAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'descriptiveAnswer': descriptiveAnswer,
    };
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      question: map['question'] ?? '',
      options: List<String>.from(map['options']),
      descriptiveAnswer: map['descriptiveAnswer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) =>
      AnswerModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AnswerModel(question: $question, options: $options, descriptiveAnswer: $descriptiveAnswer)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnswerModel &&
        other.question == question &&
        listEquals(other.options, options) &&
        other.descriptiveAnswer == descriptiveAnswer;
  }

  @override
  int get hashCode =>
      question.hashCode ^ options.hashCode ^ descriptiveAnswer.hashCode;
}
