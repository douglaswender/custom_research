import 'package:signals_flutter/signals_flutter.dart';

class HomeController {
    final _count = signal<int>(0);
    int get count => _count.value;
    void increment() => _count.value = _count.value + 1;
}

