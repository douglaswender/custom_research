import 'package:custom_research/core/constants/theme.dart';
import 'package:custom_research/feature/research/controller/research_state.dart';
import 'package:custom_research/feature/research/model/research_model.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.load(researchId: widget.id);
    });
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
                if (currentState is ResearchStateSubmitedState) {
                  Modular.to.pushReplacementNamed('/');
                }
                switch (currentState) {
                  case (ResearchStateSuccessState _ ||
                        ResearchStateSubmitLoadingState _):
                    ResearchModel? research;

                    if (currentState is ResearchStateSuccessState) {
                      research = currentState.research;
                    } else {
                      research =
                          (currentState as ResearchStateSubmitLoadingState)
                              .research;
                    }

                    if (research == null) {
                      return const Text(
                          'Opa, essa pesquisa não está disponível!');
                    }
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
                            onSubmit: () {
                              controller.submit(researchId: widget.id);
                            },
                            isLoading:
                                currentState is ResearchStateSubmitLoadingState,
                            onChange: (answer) {
                              if (answer != null) {
                                controller.addAnswer(answer);
                              }
                            },
                          ),
                        const SizedBox(
                          height: 32,
                        )
                      ],
                    );
                  case ResearchStateLoadingState _ ||
                        ResearchStateInitialState _:
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height - 20,
                      child: const Center(child: CircularProgressIndicator()),
                    );
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
