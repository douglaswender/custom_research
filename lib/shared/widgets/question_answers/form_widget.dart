import 'package:custom_research/feature/research/model/question_model.dart';
import 'package:custom_research/shared/widgets/button_widget.dart';
import 'package:custom_research/shared/widgets/question_answers/question_answers_controller.dart';
import 'package:custom_research/shared/widgets/question_answers/question_answers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class QuestionFormWidget extends StatefulWidget {
  final QuestionAnswersController? controller;
  final List<QuestionModel> questions;
  const QuestionFormWidget(
      {super.key, this.controller, required this.questions});

  @override
  State<QuestionFormWidget> createState() => _QuestionFormWidgetState();
}

class _QuestionFormWidgetState extends State<QuestionFormWidget> {
  late final QuestionAnswersController _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = widget.controller ?? QuestionAnswersController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        ...widget.questions.map((e) => QuestionAnswerField(
              controller: _controller,
              question: e,
              validator: e.required
                  ? (value) {
                      if (value == null || value.options.isEmpty) {
                        return 'Opa! Essa pergunta é obrigatória.';
                      }
                      if (!e.hasOther &&
                          e.otherText != null &&
                          value.descriptiveAnswer == null) {
                        return 'Opa! Essa pergunta é obrigatória.';
                      }
                      return null;
                    }
                  : null,
              onChange: ({checkedList}) {
                final map = {e.title: checkedList};

                print(map);
              },
            )),
        ButtonWidget(
          text: 'Validar e enviar',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Modular.to.pushReplacementNamed('/');
            }
          },
        ),
      ]),
    );
  }
}
