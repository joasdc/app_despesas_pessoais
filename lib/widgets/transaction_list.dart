import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../main.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removeTransaction;

  TransactionList(this.transactions, this.removeTransaction, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.only(bottom: 40),
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Nenhuma Transação Cadastrada",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    // Sleep icons created by Freepik - Flaticon
                    "assets/images/sleep.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            "R\$ ${transaction.value.toStringAsFixed(2)}",
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ExpensesApp.grayColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(transaction.date),
                      style: const TextStyle(
                        color: ExpensesApp.lightGrayColor,
                      ),
                    ),
                    trailing: IconButton(
                      splashRadius: 28,
                      icon: Icon(
                        Icons.delete_outline,
                        color: ExpensesApp.dangerColor,
                      ),
                      onPressed: () => removeTransaction(transaction.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
