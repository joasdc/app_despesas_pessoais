import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboard;
  final Function() onSubmit;
  final TextEditingController controller;

  AdaptativeTextField({
    required this.label,
    required this.keyboard,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CupertinoTextField(
              placeholder: label,
              placeholderStyle: const TextStyle(color: ExpensesApp.grayColor),
              decoration: BoxDecoration(
                border: Border.all(color: ExpensesApp.lightGrayColor),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
              keyboardType: keyboard,
              onSubmitted: (_) => onSubmit,
              controller: controller,
            ),
          )
        : TextField(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: ExpensesApp.grayColor),
              floatingLabelStyle:
                  const TextStyle(color: ExpensesApp.primaryColor),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: ExpensesApp.primaryColor),
              ),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ExpensesApp.lightGrayColor)),
            ),
            onSubmitted: (_) => onSubmit,
            controller: controller,
            keyboardType: keyboard,
          );
  }
}
