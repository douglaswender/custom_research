import 'package:custom_research/core/constants/theme.dart';
import 'package:custom_research/shared/widgets/chart/chart_colors.dart';
import 'package:custom_research/shared/widgets/chart/chat_model.dart';
import 'package:custom_research/shared/widgets/chart/indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  final List<ChartModel> charts;
  const ChartWidget({super.key, required this.charts});

  @override
  State<StatefulWidget> createState() => ChartWidgetState();
}

class ChartWidgetState extends State<ChartWidget> {
  int touchedIndex = -1;

  double percentage = 0;

  @override
  void initState() {
    for (final chart in widget.charts) {
      percentage += chart.value;
    }
    print(percentage);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: showingSections(),
            ),
          ),
        ),
        const SizedBox(
          width: 32,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.charts.indexed
              .map((e) => Indicator(
                  color: ChartColors.colors[e.$1],
                  text: e.$2.title,
                  isSquare: true))
              .toList(),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.from(widget.charts.indexed.map((e) {
      int i = e.$1;
      ChartModel model = e.$2;
      print(model.value / percentage);
      final isTouched = e.$1 == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: ChartColors.colors[i],
        value: model.value.toDouble(),
        title:
            '${(model.value / percentage * 100).toStringAsFixed(2).replaceAll('.', ',')}%',
        radius: radius,
        showTitle: true,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: kBodyTextPrimaryColor,
          shadows: shadows,
        ),
      );
    }));
  }
}
