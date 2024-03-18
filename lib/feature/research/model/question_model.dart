import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuestionModel {
  final String title;
  final List<String> answers;
  final bool hasOther;
  final String? otherText;
  final bool multiselect;
  final bool required;

  QuestionModel({
    required this.title,
    required this.answers,
    required this.hasOther,
    this.otherText,
    required this.multiselect,
    required this.required,
  });

  QuestionModel copyWith({
    String? title,
    List<String>? answers,
    bool? hasOther,
    ValueGetter<String?>? otherText,
    bool? multiselect,
    bool? required,
  }) {
    return QuestionModel(
      title: title ?? this.title,
      answers: answers ?? this.answers,
      hasOther: hasOther ?? this.hasOther,
      otherText: otherText != null ? otherText() : this.otherText,
      multiselect: multiselect ?? this.multiselect,
      required: required ?? this.required,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'answers': answers,
      'hasOther': hasOther,
      'otherText': otherText,
      'multiselect': multiselect,
      'required': required,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      title: map['title'] ?? '',
      answers: List<String>.from(map['answers']),
      hasOther: map['hasOther'] ?? false,
      otherText: map['otherText'],
      multiselect: map['multiselect'] ?? false,
      required: map['required'] ?? false,
    );
  }

  @override
  String toString() {
    return 'QuestionModel(title: $title, answers: $answers, hasOther: $hasOther, otherText: $otherText, multiselect: $multiselect, required: $required)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionModel &&
        other.title == title &&
        listEquals(other.answers, answers) &&
        other.hasOther == hasOther &&
        other.otherText == otherText &&
        other.multiselect == multiselect &&
        other.required == required;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        answers.hashCode ^
        hasOther.hashCode ^
        otherText.hashCode ^
        multiselect.hashCode ^
        required.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source));
}
