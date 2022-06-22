import 'package:flutter/material.dart';

import '../main.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double) newTransaction;

  TransactionForm(this.newTransaction, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // Controllers
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    // herança de TransactionForm, através de widget, conseguimos acessar todos os parâmetros passados.
    widget.newTransaction(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Título',
                labelStyle: TextStyle(color: ExpensesApp.grayColor),
                floatingLabelStyle: TextStyle(color: ExpensesApp.primaryColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ExpensesApp.primaryColor)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ExpensesApp.lightGrayColor)),
              ),
              onSubmitted: (_) => _submitForm(),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                labelStyle: TextStyle(color: ExpensesApp.grayColor),
                floatingLabelStyle: TextStyle(color: ExpensesApp.primaryColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ExpensesApp.primaryColor)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ExpensesApp.lightGrayColor)),
              ),
              controller: _valueController,
              onSubmitted: (_) => _submitForm(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text('Nova Transação'),
                style: TextButton.styleFrom(
                  primary: ExpensesApp.primaryColor,
                ),
                onPressed: _submitForm,
              ),
            )
          ],
        ),
      ),
    );
  }
}
