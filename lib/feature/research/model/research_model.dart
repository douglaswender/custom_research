import 'package:flutter/foundation.dart';

import 'package:custom_research/feature/research/model/question_model.dart';

class ResearchModel {
  final String id;
  final String title;
  final String? description;
  final List<QuestionModel>? questions;
  ResearchModel({
    required this.id,
    required this.title,
    this.description,
    this.questions,
  });

  ResearchModel copyWith({
    String? id,
    String? title,
    ValueGetter<String?>? description,
    ValueGetter<List<QuestionModel>?>? questions,
  }) {
    return ResearchModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description != null ? description() : this.description,
      questions: questions != null ? questions() : this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questions': questions?.map((x) => x.toMap()).toList(),
    };
  }

  factory ResearchModel.fromMap(Map<String, dynamic> map) {
    return ResearchModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      questions: map['questions'] != null
          ? List<QuestionModel>.from(
              map['questions']?.map((x) => QuestionModel.fromMap(x)))
          : null,
    );
  }

  @override
  String toString() {
    return 'ResearchModel(id: $id, title: $title, description: $description, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResearchModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        questions.hashCode;
  }
}
