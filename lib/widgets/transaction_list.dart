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
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "Nenhuma Transação Cadastrada",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.5,
                  child: Image.asset(
                    // Sleep icons created by Freepik - Flaticon
                    "assets/images/sleep.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Card(
                elevation: 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
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
                  trailing: MediaQuery.of(context).size.width > 480
                      ? TextButton.icon(
                          onPressed: () => removeTransaction(transaction.id),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: ExpensesApp.dangerColor,
                          ),
                          label: const Text(
                            "Excluir",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            primary: ExpensesApp.dangerColor,
                          ),
                        )
                      : IconButton(
                          splashRadius: 28,
                          icon: const Icon(
                            Icons.delete_outline,
                            color: ExpensesApp.dangerColor,
                          ),
                          onPressed: () => removeTransaction(transaction.id),
                        ),
                ),
              );
            },
          );
  }
}
