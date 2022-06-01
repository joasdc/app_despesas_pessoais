import 'package:flutter/material.dart';
import '../main.dart';

class TransactionForm extends StatelessWidget {
  final Function(String, double) newTransaction;

  TransactionForm(this.newTransaction, {Key? key}) : super(key: key);

  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

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
                labelStyle: TextStyle(color: HomePage.grayTitleText),
                floatingLabelStyle: TextStyle(color: HomePage.primaryColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: HomePage.primaryColor)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: HomePage.graySubtitleText)),
              ),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                labelStyle: TextStyle(color: HomePage.grayTitleText),
                floatingLabelStyle: TextStyle(color: HomePage.primaryColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: HomePage.primaryColor)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: HomePage.graySubtitleText)),
              ),
              controller: _valueController,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text('Nova Transação'),
                style: TextButton.styleFrom(
                  primary: HomePage.primaryColor,
                ),
                onPressed: () {
                  final title = _titleController.text;
                  final value = double.tryParse(_valueController.text) ?? 0.0;
                  newTransaction(title, value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
