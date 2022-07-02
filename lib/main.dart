import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  static const dangerColor = Color.fromARGB(255, 245, 118, 129);
  static const grayColor = Color.fromARGB(255, 145, 149, 157);
  static const lightGrayColor = Color.fromARGB(255, 194, 197, 202);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
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
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool displayChart = false;

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
        isScrollControlled: true,
        builder: (ctxt) {
          return TransactionForm(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final isIOS = Platform.isIOS;

    Widget _getIconButton(IconData icon, Function() fn) {
      return isIOS
          ? GestureDetector(onTap: fn, child: Icon(icon))
          : IconButton(onPressed: fn, icon: Icon(icon));
    }

    final iconList = isIOS ? CupertinoIcons.refresh : Icons.list_alt_rounded;
    final chartIcon = isIOS ? CupertinoIcons.refresh : Icons.bar_chart_rounded;

    final actions = [
      isLandscape
          ? _getIconButton(
              displayChart ? iconList : chartIcon,
              () => setState(() {
                displayChart = !displayChart;
              }),
            )
          : Container(),
      _getIconButton(isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTransactionFormModal(context))
    ];

    final appBar = AppBar(
      backgroundColor: ExpensesApp.primaryColor,
      title: const Text(
        'Despesas Pessoais',
      ),
      actions: actions,
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (displayChart || !isLandscape)
            Container(
              height: availableHeight * (isLandscape ? 0.8 : 0.3),
              child: Chart(_recentTransactions),
            ),
          if (!displayChart || !isLandscape)
            Container(
              height: availableHeight * (isLandscape ? 1.0 : 0.7),
              child: TransactionList(_transactions, _removeTransaction),
            ),
        ],
      ),
    ));

    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: ExpensesApp.primaryColor,
                    child: const Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
