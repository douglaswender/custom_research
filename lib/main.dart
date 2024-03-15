import 'package:custom_research/firebase_options.dart';
import 'package:custom_research/main_module.dart';
import 'package:custom_research/main_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Modular.to.addListener(() async {
    await FirebaseAnalytics.instance.logScreenView(screenName: Modular.to.path);
  });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ModularApp(
    module: MainModule(),
    child: const MainWidget(),
  ));
}
