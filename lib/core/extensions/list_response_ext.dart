import 'package:custom_research/shared/widgets/chart/chat_model.dart';

extension ListResponseExt on List<String> {
  List<ChartModel> convertToChart() {
    Map<String, dynamic> contagem = {};

    for (String resposta in this) {
      if (contagem.containsKey(resposta)) {
        contagem[resposta] += 1;
      } else {
        contagem[resposta] = 1;
      }
    }
    List<ChartModel> charts = [];
    contagem.forEach((key, value) {
      charts.add(ChartModel(title: key, value: value));
    });

    return charts;
  }
}
