import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((transaction) {
        return Card(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: HomePage.primaryColor,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  "R\$ ${transaction.value.toStringAsFixed(2).replaceAll('.', ',')}",
                  style: const TextStyle(
                    color: HomePage.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      color: HomePage.grayTitleText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('d MMM y').format(transaction.date),
                    style: const TextStyle(color: HomePage.graySubtitleText),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
