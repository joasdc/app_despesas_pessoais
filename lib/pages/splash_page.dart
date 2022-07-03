import 'package:flutter/material.dart';

import 'package:despesas_pessoais/main.dart';
import 'package:despesas_pessoais/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((_) =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ExpensesApp.primaryColor,
      child: const Center(
        child: Text(
          'Despesas Pessoais',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            decoration: TextDecoration.none,
          ),
          textScaleFactor: 1.5,
        ),
      ),
    );
  }
}
