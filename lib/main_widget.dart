import 'package:custom_research/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kBgColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: kBodyTextPrimaryColor),
        bodyMedium: TextStyle(color: kBodyTextPrimaryColor),
        headlineSmall: TextStyle(color: kDarkBlackColor),
      ),
    );
    return MaterialApp.router(
      title: 'Pesquisa',
      theme: baseTheme.copyWith(
          textTheme: GoogleFonts.nunitoTextTheme(baseTheme.textTheme)),
      routerConfig: Modular.routerConfig,
    );
  }
}
