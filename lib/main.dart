import 'package:despesas_pessoais/models/transaction.dart';
import 'package:despesas_pessoais/widgets/transaction_form.dart';
import 'package:despesas_pessoais/widgets/transaction_list.dart';
import 'package:despesas_pessoais/widgets/transaction_user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static const primaryColor = Color.fromARGB(255, 118, 165, 238);
  static const dangerColor = Color.fromARGB(255, 254, 186, 214);
  static const grayTitleText = Color.fromARGB(255, 145, 149, 157);
  static const graySubtitleText = Color.fromARGB(255, 194, 197, 202);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Despesas Pessoais'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.yellowAccent,
              elevation: 5,
              child: Text('Gráfico'),
            ),
          ),
          TransactionUser(),
        ],
      ),
    );
  }
}
