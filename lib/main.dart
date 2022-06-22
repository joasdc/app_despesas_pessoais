import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_form.dart';
import 'widgets/transaction_list.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  static const primaryColor = Color.fromARGB(255, 118, 165, 238);
  static const dangerColor = Color.fromARGB(255, 254, 186, 214);
  static const grayColor = Color.fromARGB(255, 145, 149, 157);
  static const lightGrayColor = Color.fromARGB(255, 194, 197, 202);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
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

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addNewTransaction(String title, double value, DateTime transactionDate) {
    final newTransaction = Transaction(
      id: (_transactions.length + 1).toString(),
      title: title,
      value: value,
      date: transactionDate,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Apagar Transação'),
            content: const Text('Deseja apagar esta transação?'),
            actions: [
              TextButton(
                child: const Text(
                  'Não',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: ExpensesApp.primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Sim',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: ExpensesApp.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _transactions
                        .removeWhere((transaction) => transaction.id == id);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctxt) {
          return TransactionForm(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ExpensesApp.primaryColor,
        title: const Text(
          'Despesas Pessoais',
        ),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_transactions, _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ExpensesApp.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
