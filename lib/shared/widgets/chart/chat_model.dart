class ChartModel {
  final String title;
  final int value;

  ChartModel({required this.title, required this.value});

  @override
  String toString() => 'ChartModel(title: $title, value: $value)';
}
