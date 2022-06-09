import 'package:despesas_pessoais/widgets/transaction_form.dart';
import 'package:despesas_pessoais/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:despesas_pessoais/models/transaction.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  static const primaryColor = Color.fromARGB(255, 118, 165, 238);
  static const dangerColor = Color.fromARGB(255, 254, 186, 214);
  static const grayTitleText = Color.fromARGB(255, 145, 149, 157);
  static const graySubtitleText = Color.fromARGB(255, 194, 197, 202);

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
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: "1",
    //   title: "Conta de Luz",
    //   value: 452.60,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "2",
    //   title: "Mensalidade da Faculdade",
    //   value: 258.60,
    //   date: DateTime.now(),
    // ),
  ];

  _addNewTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: (_transactions.length + 1).toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
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
        title: Text(
          'Despesas Pessoais',
        ),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ExpensesApp.primaryColor,
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
