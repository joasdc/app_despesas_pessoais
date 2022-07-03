import 'package:flutter/material.dart';

import 'package:despesas_pessoais/widgets/adaptative_button.dart';
import 'package:despesas_pessoais/widgets/adaptative_date_picker.dart';
import 'package:despesas_pessoais/widgets/adaptative_text_field.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) newTransaction;

  const TransactionForm(this.newTransaction, {Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
            left: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AdaptativeTextField(
                label: 'Título',
                keyboard: TextInputType.text,
                controller: _titleController,
                onSubmit: _submitForm,
              ),
              AdaptativeTextField(
                label: 'Valor (R\$)',
                keyboard: const TextInputType.numberWithOptions(decimal: true),
                controller: _valueController,
                onSubmit: _submitForm,
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AdaptativeButton(
                  label: 'Nova Transação',
                  onPressed: _submitForm,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
