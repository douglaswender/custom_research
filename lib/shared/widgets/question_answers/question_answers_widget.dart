import 'package:custom_research/core/constants/theme.dart';
import 'package:custom_research/feature/research/model/answer_model.dart';
import 'package:custom_research/feature/research/model/question_model.dart';
import 'package:custom_research/shared/widgets/question_answers/question_answers_controller.dart';
import 'package:flutter/material.dart';

class QuestionAnswerField extends FormField<AnswerModel> {
  final QuestionModel question;
  final void Function({AnswerModel? checkedList}) onChange;
  final QuestionAnswersController? controller;
  QuestionAnswerField({
    super.key,
    super.validator,
    super.autovalidateMode = AutovalidateMode.disabled,
    required this.question,
    required this.onChange,
    this.controller,
  }) : super(builder: (FormFieldState<AnswerModel> field) {
          void onChangedHandler(AnswerModel value) {
            field.didChange(value);
            onChange.call(checkedList: value);
          }

          return QuestionAnswerWidget(
              question: question,
              onChange: onChangedHandler,
              hasError: field.hasError,
              errorText: field.errorText);
        });
}

class QuestionAnswerWidget extends StatefulWidget {
  final QuestionModel question;
  final QuestionAnswersController? controller;
  final bool hasError;
  final String? errorText;
  final void Function(AnswerModel checkedList) onChange;
  const QuestionAnswerWidget({
    super.key,
    required this.question,
    required this.onChange,
    this.controller,
    this.hasError = false,
    this.errorText,
  });

  @override
  State<QuestionAnswerWidget> createState() => _QuestionAnswerWidgetState();
}

class _QuestionAnswerWidgetState extends State<QuestionAnswerWidget> {
  late AnswerModel answer;
  String? currentAnswer;
  bool otherSelected = false;

  late QuestionAnswersController _controller;

  @override
  void initState() {
    answer = AnswerModel(question: widget.question.title, options: []);
    _controller = widget.controller ?? QuestionAnswersController();
    _controller.answers.add(answer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: widget.hasError
                ? Border.all(
                    color: kPrimaryColor,
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(widget.question.title),
                if (widget.question.multiselect)
                  Column(
                    children: [
                      ...widget.question.answers.map(
                        (e) => Row(
                          children: [
                            Checkbox(
                              value: answer.options.contains(e),
                              checkColor: kDarkBlackColor,
                              activeColor: kPrimaryColor,
                              onChanged: (value) {
                                if (value!) {
                                  setState(() {
                                    answer.options.add(e);
                                  });
                                  widget.onChange(
                                    answer,
                                  );
                                } else {
                                  setState(() {
                                    answer.options.remove(e);
                                  });
                                  widget.onChange(
                                    answer,
                                  );
                                }
                              },
                            ),
                            Expanded(child: Text(e))
                          ],
                        ),
                      ),
                      if (widget.question.hasOther)
                        Row(
                          children: [
                            Checkbox(
                              value: answer.options.contains(
                                  widget.question.otherText ?? 'Outro'),
                              checkColor: kDarkBlackColor,
                              activeColor: kPrimaryColor,
                              onChanged: (value) {
                                if (value!) {
                                  setState(() {
                                    answer.options.add(
                                        widget.question.otherText ?? 'Outro');
                                    otherSelected = true;
                                  });
                                  widget.onChange(
                                    answer,
                                  );
                                } else {
                                  setState(() {
                                    otherSelected = false;
                                    answer.options.remove(
                                        widget.question.otherText ?? 'Outro');
                                  });
                                  widget.onChange(
                                    answer,
                                  );
                                }
                              },
                            ),
                            Text(widget.question.otherText ?? 'Outro'),
                            if (otherSelected) ...[
                              const SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                height: 32,
                                width: 300,
                                child: TextFormField(
                                  cursorColor: kBodyTextPrimaryColor,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: kBodyTextPrimaryColor),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: kBodyTextPrimaryColor,
                                      ),
                                    ),
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.center,
                                    labelText: widget.question.otherText,
                                    labelStyle: const TextStyle(
                                        color: kBodyTextPrimaryColor),
                                  ),
                                  onChanged: (value) {
                                    answer = answer.copyWith(
                                        descriptiveAnswer:
                                            "${widget.question.otherText ?? 'Outro'} - $value");
                                    widget.onChange(answer);
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...widget.question.answers.map(
                        (e) => Row(
                          children: [
                            Radio<String?>(
                              activeColor: kPrimaryColor,
                              groupValue: currentAnswer,
                              value: e,
                              onChanged: (value) {
                                answer.options.clear();
                                setState(() {
                                  currentAnswer = value;
                                  answer.options.add(currentAnswer!);
                                });
                                widget.onChange(
                                  answer,
                                );
                              },
                            ),
                            Text(e)
                          ],
                        ),
                      ),
                      if (!widget.question.hasOther &&
                          widget.question.otherText != null)
                        SizedBox(
                          height: 50,
                          width: 140,
                          child: TextFormField(
                            cursorColor: kBodyTextPrimaryColor,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: kBodyTextPrimaryColor),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kBodyTextPrimaryColor,
                                ),
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              labelText: widget.question.otherText,
                              labelStyle:
                                  const TextStyle(color: kBodyTextPrimaryColor),
                            ),
                            onChanged: (value) {
                              answer = answer.copyWith(
                                  descriptiveAnswer: "$currentAnswer - $value");
                              widget.onChange(answer);
                            },
                          ),
                        ),
                      if (widget.question.hasOther)
                        Row(
                          children: [
                            Radio<String?>(
                              groupValue: currentAnswer,
                              value: widget.question.otherText ?? 'Outro',
                              onChanged: (value) {
                                answer.options.clear();
                                setState(() {
                                  currentAnswer = value;
                                  answer.options.add(currentAnswer!);
                                });
                                widget.onChange(
                                  answer,
                                );
                              },
                            ),
                            Text(widget.question.otherText ?? 'Outro')
                          ],
                        )
                    ],
                  ),
                if (widget.hasError && widget.question.required)
                  Text(
                    widget.errorText ?? 'Opa!',
                    style: const TextStyle(color: kBodyTextSecondaryColor),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
