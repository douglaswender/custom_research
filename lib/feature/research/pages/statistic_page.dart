import 'package:custom_research/core/extensions/list_response_ext.dart';
import 'package:custom_research/feature/research/controller/statistics/statistics_controller.dart';
import 'package:custom_research/feature/research/controller/statistics/statistics_state.dart';
import 'package:custom_research/shared/widgets/app_scaffold_widget.dart';
import 'package:custom_research/shared/widgets/chart/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signals_flutter/signals_flutter.dart';

class StatisticsPage extends StatefulWidget {
  final String id;
  const StatisticsPage({super.key, required this.id});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final controller = Modular.get<StatisticsController>();

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
      body: Watch(
        (context) {
          final currentState = controller.state;

          switch (currentState) {
            case StatisticsStateSuccessState _:
              final responses = currentState.responses;

              return SingleChildScrollView(
                //physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: responses
                      .map((e) => Column(
                            children: [
                              Text(e.question),
                              const SizedBox(
                                height: 16,
                              ),
                              ChartWidget(charts: e.responses.convertToChart()),
                              const SizedBox(
                                height: 16,
                              )
                            ],
                          ))
                      .toList(),
                ),
              );
            default:
              return SizedBox(
                height: MediaQuery.sizeOf(context).height - 20,
                child: const Center(child: CircularProgressIndicator()),
              );
          }
        },
      ),
    );
  }
}
