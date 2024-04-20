import 'dart:io';

import 'package:app/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addExpense, {super.key});

  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  void _saveNewExpenses() {
    final amount = double.tryParse(_amountController.text);
    final title = _titleController.text.trim();
    final invalidAmount = amount == null || amount <= 0;
    final invalidTitle = title.isEmpty;
    final invalidDate = _selectedDate == null;

    var customShowDialog = Platform.isIOS ? showCupertinoDialog : showDialog;
    if (invalidTitle || invalidAmount || invalidDate) {
      customShowDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure inputs are filled and valid.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }

    widget.addExpense(Expense(
        title: title,
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory!));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      Widget titleInput = TextField(
        controller: _titleController,
        maxLength: 50,
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
      );

      Widget amountInput = TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          prefixText: '\$ ',
          label: Text('Amount'),
        ),
      );

      Widget categoryDropdown = DropdownButton(
        value: _selectedCategory,
        items: Category.values
            .map(
              (category) => DropdownMenuItem(
                value: category,
                child: Text(
                  category.name.toUpperCase(),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value == null) {
            return;
          }
          setState(() {
            _selectedCategory = value;
          });
        },
      );

      Widget dateInput = Expanded(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _selectedDate == null
                    ? 'Select a date'
                    : dateFormatter.format(_selectedDate!),
              ),
              IconButton(
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime.now())
                        .then((value) => setState(() {
                              _selectedDate = value;
                            }));
                  },
                  icon: const Icon(Icons.calendar_month))
            ]),
      );

      Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      );

      Widget saveButton = ElevatedButton(
        onPressed: _saveNewExpenses,
        child: const Text('Save Expense'),
      );

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: titleInput),
                      const SizedBox(width: 24),
                      Expanded(child: amountInput),
                    ],
                  )
                else
                  titleInput,
                if (width >= 600)
                  Row(children: [
                    categoryDropdown,
                    const SizedBox(width: 24),
                    dateInput,
                  ])
                else
                  Row(
                    children: [
                      Expanded(child: amountInput),
                      const SizedBox(width: 16),
                      dateInput,
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(children: [
                    const Spacer(),
                    cancelButton,
                    saveButton,
                  ])
                else
                  Row(
                    children: [
                      categoryDropdown,
                      const Spacer(),
                      cancelButton,
                      saveButton,
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
