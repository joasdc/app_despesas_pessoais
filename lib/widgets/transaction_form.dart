import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../main.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) newTransaction;

  TransactionForm(this.newTransaction, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // Controllers
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    // herança de TransactionForm, através de widget, conseguimos acessar todos os parâmetros passados.
    widget.newTransaction(title, value, _selectedDate);
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      } else {
        return;
      }
    });
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
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate != null
                        ? 'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'
                        : 'Nenhuma data selecionada',
                  ),
                  TextButton(
                    child: const Text(
                      'Selecionar data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: ExpensesApp.primaryColor,
                    ),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                child: const Text(
                  'Nova Transação',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
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
