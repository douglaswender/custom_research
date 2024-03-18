import 'package:custom_research/core/constants/theme.dart';
import 'package:custom_research/feature/research/controller/research_state.dart';
import 'package:custom_research/shared/widgets/app_scaffold_widget.dart';
import 'package:custom_research/shared/widgets/question_answers/form_widget.dart';
import 'package:custom_research/shared/widgets/question_answers/question_answers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'controller/research_controller.dart';

class ResearchPage extends StatefulWidget {
  final String id;
  const ResearchPage({
    super.key,
    required this.id,
  });

  @override
  State<ResearchPage> createState() => _ResearchPageState();
}

class _ResearchPageState extends State<ResearchPage> {
  final controller = Modular.get<ResearchController>();
  final QuestionAnswersController questionController =
      QuestionAnswersController();
  @override
  void initState() {
    super.initState();
    controller.load(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Watch(
              (_) {
                final currentState = controller.state;
                switch (currentState) {
                  case ResearchStateSuccessState _:
                    final research =
                        (controller.state as ResearchStateSuccessState)
                            .research;
                    return Column(
                      children: [
                        Text(
                          research.title,
                          style: kTitleTextStyle,
                        ),
                        if (research.description != null)
                          Text(research.description!),
                        const SizedBox(
                          height: 32,
                        ),
                        if (research.questions != null)
                          QuestionFormWidget(
                            controller: questionController,
                            questions: research.questions!,
                          ),
                        const SizedBox(
                          height: 32,
                        )
                      ],
                    );
                  case ResearchStateLoadingState _ ||
                        ResearchStateInitialState _:
                    return const CircularProgressIndicator();
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
