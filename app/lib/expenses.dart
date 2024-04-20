import 'package:app/components/chart.dart';
import 'package:app/components/expense_list.dart';
import 'package:app/components/new_expense.dart';
import 'package:app/models/expense_model.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _dummyExpenses = [
    Expense(
      title: 'Burger',
      amount: 11.99,
      date: DateTime(2024, 4, 18, 19),
      category: Category.food,
    ),
    Expense(
      title: 'Flight Ticket',
      amount: 1100.99,
      date: DateTime(2024, 4, 17, 00),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _dummyExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      final expenseIndex = _dummyExpenses.indexOf(expense);
      _dummyExpenses.remove(expense);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Expense removed.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _dummyExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;

    Widget content = _dummyExpenses.isEmpty
        ? const Text(
            'No expenses yet.\n Press "+" to start adding expense.',
            textAlign: TextAlign.center,
            // style: TextStyle(height: 2),
          )
        : ExpensesList(_dummyExpenses, _removeExpense);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _openAddExpenseOverlay,
            ),
          ],
        ),
        body: mediaWidth < 600
            ? Column(
                children: [
                  Chart(expenses: _dummyExpenses),
                  Expanded(child: content),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _dummyExpenses)),
                  Expanded(child: content),
                ],
              ));
  }
}
