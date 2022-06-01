import 'package:flutter/material.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:despesas_pessoais/widgets/transaction_form.dart';
import 'package:despesas_pessoais/widgets/transaction_list.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({Key? key}) : super(key: key);

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final List<Transaction> _transactions = [
    Transaction(
      id: "1",
      title: "Conta de Luz",
      value: 452.60,
      date: DateTime.now(),
    ),
    Transaction(
      id: "2",
      title: "Mensalidade da Faculdade",
      value: 258.60,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions),
        TransactionForm(),
      ],
    );
  }
}
