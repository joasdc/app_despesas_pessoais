import 'package:flutter/material.dart';

import 'package:despesas_pessoais/pages/splash_page.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  static const primaryColor = Color.fromARGB(255, 118, 165, 238);
  static const dangerColor = Color.fromARGB(255, 245, 118, 129);
  static const grayColor = Color.fromARGB(255, 145, 149, 157);
  static const lightGrayColor = Color.fromARGB(255, 194, 197, 202);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashPage(),
      theme: ThemeData(
        fontFamily: "Quicksand",
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
